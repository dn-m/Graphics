//
//  LayoutNode.swift
//  Rendering
//
//  Created by James Bean on 1/16/17.
//
//

import DataStructures
import QuartzCore

/// Wrapper for a CALayer, managing automated layout
public final class LayoutNode: ReferenceTreeProtocol {
    
    // MARK: - Instance Properties
    
    /// Content layer controlled by this `LayoutNode`.
    public let layer: CALayer
    
    /// Parent `LayoutNode`, if present. Otherwise, `nil`.
    public var parent: LayoutNode?
    
    /// Children `LayoutNode` objects.
    public var children: [LayoutNode] = []
    
    /// The direction to flow child `LayoutNode` objects horizontally.
    public var horizontalAlignment: HorizontalLayoutPosition = .none
    
    /// The direction to flow child `LayoutNode` objects vertically.
    public var verticalAlignment: VerticalLayoutPosition = .none
    
    /// The origin from which to stack child `LayoutNode` objects horizontally.
    public var horizontalStackOrigin: HorizontalLayoutPosition = .none
    
    /// The origin from which to stack child `LayoutNode` objects vertically.
    public var verticalStackOrigin: VerticalLayoutPosition = .none
    
    /// Whether or not to calculate the width of `layer` with those of the children.
    public var setsWidthWithChildren: Bool = true
    
    /// Whether or not to calculate the height of `layer` with those of the children.
    public var setsHeightWithChildren: Bool = true
    
    /// Contains values for top, bottom, left, right padding values.
    public var padding = Padding()
    
    /// Frame of `LayoutNode`. Updates the `frame` property of the `layer` object.
    internal var frame: CGRect = CGRect.zero {
        didSet {
            layer.frame = frame
        }
    }
    
    // Frame for this `LayoutNode` stored in the layout process before being committed
    internal lazy var frameForLayout: CGRect = { return self.frame }()
    
    // Stored positions calculated for each child `LayoutNode` before moving them
    internal var frameByChild: [LayoutNode: CGRect] = [:]
    
    // MARK: - Initializers
    
    /// Create a `LayoutNode` with a given `layer` and layout configuration.
    public init(
        _ layer: CALayer = CALayer(),
        stackingVerticallyFrom verticalStackOrigin: VerticalLayoutPosition = .none,
        stackingHorizontallyFrom horizontalStackOrigin: HorizontalLayoutPosition = .none,
        aligningVerticallyTo verticalAlignment: VerticalLayoutPosition = .none,
        aligningHorizontallyTo horizontalAlignment: HorizontalLayoutPosition = .none
    )
    {
        self.layer = layer
        self.frame = layer.frame
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.verticalStackOrigin = verticalStackOrigin
        self.horizontalStackOrigin = horizontalStackOrigin
        layer.drawsAsynchronously = true
    }
    
    // MARK: - Position

    /// - warning: Not yet implemented!
    public func move(to origin: CGPoint, animated: Bool = false) {
        fatalError()
    }
    
    
    /// - warning: Not yet implemented!
    public func move(
        horizontallyBy tx: CGFloat = 0,
        verticallyBy ty: CGFloat = 0,
        animated: Bool = false
    )
    {
        fatalError()
    }
}

extension LayoutNode: Equatable { }

public func == (lhs: LayoutNode, rhs: LayoutNode) -> Bool {
    return lhs.layer === rhs.layer
}

extension LayoutNode: Hashable {
    
    public var hashValue: Int { return layer.hashValue }
}

extension LayoutNode {
    
    // MARK: - Layout
    
    /// Positions used for vertical stacking and aligning `LayoutNode` objects.
    public enum VerticalLayoutPosition {
        
        /// No vertical layout position.
        case none
        
        /// Top.
        case top

        /// Middle.
        case middle
        
        /// Bottom.
        case bottom
    }
    
    /// Positions used for horizontally stacking and aligning `LayoutNode` objects.
    public enum HorizontalLayoutPosition {
        
        /// No horizontal layout position
        case none
        
        /// Left.
        case left

        /// Center.
        case center
        
        /// Right.
        case right
    }
    
    
    /// Amount of space to each side of a `LayoutNode`.
    ///
    /// - TODO: Make `init` with a scale of a given size attribute of a `LayoutNode`.
    public struct Padding {
        
        /// Padding above a `LayoutNode`.
        public var top: CGFloat
        
        /// Padding below a `LayoutNode`.
        public var bottom: CGFloat
        
        /// Padding to the left of a `LayoutNode`.
        public var left: CGFloat
        
        /// Padding to the right of a `LayoutNode`.
        public var right: CGFloat
        
        /// Padding value with 0 values for each side.
        public static var zero = Padding()
        
        // MARK: - Initializers
        
        /// Create a `Padding` value.
        public init(
            top: CGFloat = 0,
            bottom: CGFloat = 0,
            left: CGFloat = 0,
            right: CGFloat = 0
        )
        {
            self.top = top
            self.bottom = bottom
            self.left = left
            self.right = right
        }
        
        /// Create a `Padding` value with even padding on each side.
        public init(_ value: CGFloat) {
            self.top = value
            self.bottom = value
            self.left = value
            self.right = value
        }
    }
    
    /// Prepare for layout, then immediately commit frames.
    public func layout(animated: Bool = false) {
        prepareForLayout()
        commitLayout(animated: animated)
    }
    

    /// Calculate the frames for children nodes without committing frames.
    public func prepareForLayout() {
        prepareFrameByChildForLayout()
        stackVertically()
        setHeightWithChildren()
        stackHorizontally()
        setWidthWithChildren()
        alignVertically()
        alignHorizontally()
        parent?.prepareForLayout()
    }
    
    fileprivate func prepareFrameByChildForLayout() {
        frameByChild.removeAll(keepingCapacity: true)
        children.forEach { child in frameByChild[child] = child.frame }
    }
    
    /// Commit the layout that has been prepared by `prepareForLayout()`.
    public func commitLayout(animated: Bool = false) {
        defer { parent?.commitLayout() }
        guard isContainer else { return }
        commitFramesForChildren(animated: animated)
        commitFrameForLayout(animated: animated)
    }
    
    fileprivate func commitFramesForChildren(animated: Bool) {
        frameByChild.forEach { child, frame in
            if !animated { CATransaction.setDisableActions(true) }
            child.frame = frame
            if !animated { CATransaction.setDisableActions(false) }
        }
    }
    
    fileprivate func commitFrameForLayout(animated: Bool = false) {
        if !animated { CATransaction.setDisableActions(true) }
        frame = frameForLayout
        if !animated { CATransaction.setDisableActions(false) }
    }
    
    // MARK: - Stack Vertically
    
    fileprivate func stackVertically() {
        switch verticalStackOrigin {
        case .top: stackVerticallyFromTop()
        case .bottom: stackVerticallyFromBottom()
        default: return
        }
    }
    
    fileprivate func stackVerticallyFromTop() {
        
        guard isContainer && verticalStackOrigin == .top else { return }
        
        var accumHeight: CGFloat = 0
        for (c, child) in children.enumerated() {
            
            ensureFrame(for: child)
            
            // add top padding if not first
            if c > 0 { accumHeight += child.padding.top }
            
            // update vertical position of child
            frameByChild[child]!.origin.y = accumHeight
            
            // adjust `accumHeight`
            accumHeight += child.frame.size.height
            
            // add padding bottom for appropriate prev, cur, next nodes
            if c < children.count - 1 { accumHeight += child.padding.bottom }
        }
    }
    
    fileprivate func stackVerticallyFromBottom() {
        
        guard isContainer && verticalStackOrigin == .bottom else { return }
        
        var accumHeight: CGFloat = 0
        for (c, child) in children.reversed().enumerated() {
            
            ensureFrame(for: child)
            
            // add bottom padding if not last
            if c > 0 { accumHeight += child.padding.bottom }
            
            // update vertical position of child
            frameByChild[child]!.origin.y = accumHeight
            
            // increment `accumHeight`
            accumHeight += child.frame.size.height
            
            // add top padding if not last
            if c < children.count - 1 { accumHeight += child.padding.top }
        }
    }
    
    
    // MARK: - Stack Horizontally
    
    fileprivate func stackHorizontally() {
        switch horizontalStackOrigin {
        case .left: stackHorizontallyFromLeft()
        case .right: stackHorizontallyFromRight()
        default: break
        }
    }
    
    fileprivate func stackHorizontallyFromLeft() {
        
        guard isContainer && horizontalStackOrigin == .left else { return }
        
        var accumWidth: CGFloat = 0
        for (c, child) in children.enumerated() {
            
            // prepare origin for child
            ensureFrame(for: child)
            
            // add left padding if not first
            if c > 0 { accumWidth += child.padding.left }
            
            // update horizontal position of child
            frameByChild[child]!.origin.x = accumWidth
            
            // adjust `accumWidth`
            accumWidth += child.frame.size.width
            
            // add right padding if not last
            if c < children.count - 1 { accumWidth += child.padding.right }
        }
    }
    
    fileprivate func stackHorizontallyFromRight() {
        
        guard isContainer && horizontalStackOrigin == .right else { return }
        
        var accumWidth: CGFloat = 0
        for (c, child) in children.reversed().enumerated() {
            
            // prepare origin for child
            ensureFrame(for: child)
            
            // add right padding if not first
            if c > 0 { accumWidth += child.padding.right }
            
            // update horizontal position of child
            frameByChild[child]!.origin.x = accumWidth
            
            // adjust `accumWidth`
            accumWidth += child.frame.size.width
            
            // add left padding if not last
            if c < children.count - 1 { accumWidth += child.padding.left }
        }
    }
    
    // MARK: - Align Vertically
    
    fileprivate func alignVertically() {
        guard isContainer else { return }
        switch verticalAlignment {
        case .top: alignVerticallyTop()
        case .middle: alignVerticallyMiddle()
        case .bottom: alignVerticallyBottom()
        default: return
        }
    }
    
    fileprivate func alignVerticallyTop() {
        for child in children {
            ensureFrame(for: child)
            frameByChild[child]!.origin.y = 0
        }
    }
    
    fileprivate func alignVerticallyMiddle() {
        let middle = frameForLayout.midY
        for child in children {
            ensureFrame(for: child)
            frameByChild[child]!.origin.y = middle - 0.5 * frameByChild[child]!.size.height
        }
    }
    
    fileprivate func alignVerticallyBottom() {
        let bottom = frameForLayout.maxY
        for child in children {
            ensureFrame(for: child)
            frameByChild[child]!.origin.y = bottom - frameByChild[child]!.size.height
        }
    }
    
    // MARK: - Align Horizontally
    
    fileprivate func alignHorizontally() {
        guard isContainer else { return }
        switch horizontalAlignment {
        case .left: alignHorizontallyLeft()
        case .center: alignHorizontallyCenter()
        case .right: alignHorizontallyRight()
        default: return
        }
    }
    
    fileprivate func alignHorizontallyLeft() {
        for child in children {
            ensureFrame(for: child)
            frameByChild[child]!.origin.x = 0
        }
    }
    
    fileprivate func alignHorizontallyCenter() {
        let center = frameForLayout.midX
        for child in children {
            ensureFrame(for: child)
            frameByChild[child]!.origin.x = center - 0.5 * frameByChild[child]!.size.width
        }
    }
    
    fileprivate func alignHorizontallyRight() {
        let right = frameForLayout.maxX
        for child in children {
            ensureFrame(for: child)
            frameByChild[child]!.origin.x = right - frameByChild[child]!.size.width
        }
    }
    
    fileprivate func ensureFrame(for child: LayoutNode) {
        if frameByChild[child] == nil { frameByChild[child] = CGRect.zero }
    }
    
    // MARK: - Set size with children
    
    fileprivate func setHeightWithChildren() {
        guard isContainer && setsHeightWithChildren else { return }
        let minY = frameByChild.map { $1.minY }.min() ?? 0
        let maxY = frameByChild.map { $1.maxY }.max() ?? 0
        let height = maxY - minY
        frameForLayout.size = CGSize(width: frameForLayout.size.width, height: height)
    }
    
    fileprivate func setWidthWithChildren() {
        guard isContainer && setsWidthWithChildren else { return }
        let minX = frameByChild.map { $1.minX }.min() ?? 0
        let maxX = frameByChild.map { $1.maxX }.max() ?? 0
        let width = maxX - minX
        frameForLayout.size = CGSize(width: width, height: frameForLayout.size.height)
    }
}

extension LayoutNode {
    
    // MARK: - Add nodes
    
    /// Append child node.
    public func addChild(_ node: LayoutNode) {
        children.append(node)
        node.parent = self
        commitLayer(for: node)
    }
    
    /// Insert the given `node` at the given `index`.
    ///
    /// - throws: `NodeError.insertionError` if the given `index` is out-of-bounds.
    public func insertChild(_ node: LayoutNode, at index: Int) throws {
        
        guard index >= children.startIndex && index <= children.endIndex else {
            throw ReferenceTreeError.insertionError
        }
        
        if index == children.endIndex {
            children.append(node)
        } else {
            children.insert(node, at: index)
        }
        
        node.parent = self
        commitLayer(for: node)
    }
    
    /// Insert the given `node` before another `node`.
    ///
    /// - throws: `NodeError.insertionError` if the other `node` is not contained herein.
    public func insertChild(_ node: LayoutNode, before other: LayoutNode) throws {
        guard let index = children.index(of: other) else { throw ReferenceTreeError.insertionError }
        try insertChild(node, at: index)
    }
    
    /// Insert the given `node` after another `node`.
    ///
    /// - throws: `NodeError.insertionError` if the other `node` is not contained herein.
    public func insertChild(_ node: LayoutNode, after other: LayoutNode) throws {
        guard let index = children.index(of: other) else { throw ReferenceTreeError.insertionError }
        try insertChild(node, at: index + 1)
    }
    
    fileprivate func commitLayer(for node: LayoutNode) {
        CATransaction.setDisableActions(true)
        node.layer.removeFromSuperlayer()
        layer.addSublayer(node.layer)
        CATransaction.setDisableActions(false)
    }
}

extension LayoutNode {
    
    // MARK: - Remove nodes
    
    /// Remove a given child `node`.
    ///
    /// - throws: `NodeError.removalError` if the given `node` is not contained herein.
    public func removeChild(_ node: LayoutNode) throws {
        guard let index = children.index(of: node) else { throw ReferenceTreeError.removalError }
        try removeChild(at: index)
    }
    
    /// Remove the child node at a given `index`.
    ///
    /// - throws: `NodeError.removalError` if no node exists at the given `index`.
    public func removeChild(at index: Int) throws {
        guard children.indices.contains(index) else { throw ReferenceTreeError.removalError }
        let node = children.remove(at: index)
        removeLayer(for: node)
    }
    
    fileprivate func removeLayer(for node: LayoutNode) {
        node.layer.removeFromSuperlayer()
    }
}

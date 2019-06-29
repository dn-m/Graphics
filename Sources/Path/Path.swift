//
//  Path.swift
//  Path
//
//  Created by James Bean on 6/10/16.
//
//

import Algebra
import DataStructures
import Geometry

public struct Path: CollectionWrapping
{
    
    public typealias Base = [BezierCurve]
    
    // MARK: - Instance Properties
    
    public var isShape: Bool {
        return base.allSatisfy { curve in curve.order == .linear }
    }
    
    /// - Returns: `true` if there are no non-`.close` elements contained herein. Otherwise,
    /// `false`.
    public var isEmpty: Bool {
        return base.isEmpty
    }
    
    /// - Returns: The axis-aligned bounding box for `Path`.
    ///
    /// - Warning: This uses a simplification technique for calculateing the bounding boxes of
    /// quadratic and cubic Bézier curves, which may result in some inaccuracy for whacky curves.
    ///
    public var axisAlignedBoundingBox: Rectangle {
        return base.map { $0.axisAlignedBoundingBox }.nonEmptySum ?? .zero
    }
    
    public let base: [BezierCurve]
    
    // MARK: - Initializers

    /// Create a `Path` with a single `curve`.
    public init(_ curve: BezierCurve) {
        self.init([curve])
    }
    
    /// Create a `Path` with the given `curves`.
    public init(_ curves: Base) {
        self.base = curves
    }
    
    /// Create a `Path` with the given `pathElements`.
    public init(pathElements: [PathElement]) {
        
        guard
            let (head, tail) = pathElements.destructured, case let .move(start) = head
        else {
            self = Path([])
            return
        }
        
        let builder = Path.builder.move(to: start)
        var last = start
        
        for element in tail {
            switch element {
            case .move(let point):
                builder.move(to: point)
                last = point
            case .line(let point):
                _ = point == last ? builder.close() : builder.addLine(to: point)
            case .quadCurve(let point, let control):
                builder.addQuadCurve(to: point, control: control)
            case .curve(let point, let control1, let control2):
                builder.addCurve(to: point, control1: control1, control2: control2)
            case .close:
                builder.close()
            }
        }
        
        self = builder.build()
    }

    // MARK: - Instance Methods
    
    /// - Returns: Polygonal representation of the `Path`.
    public func simplified(segmentCount: Int) -> Polygon {
        let vertices = base.map { $0.simplified(segmentCount: segmentCount) }
        let (most, last) = vertices.split(at: vertices.count - 1)!
        let merged = most.flatMap { $0.dropLast() } + last.first!
        if merged.count == 2 {
            return Polygon(vertices: merged + merged.first!)
        }
        return Polygon(vertices: merged)
    }
}

//extension Path {
//
//    public var curves: [BezierCurve] {
//        return base
//    }
//}

extension Path: Additive {

    /// Empty path.
    public static let zero = Path([])

    /// - Returns: New `Path` with elements of two paths.
    public static func + (lhs: Path, rhs: Path) -> Path {
        return Path(lhs.base + rhs.base)
    }
}

extension Path: Equatable { }

extension Path: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        var result = "Path:\n"
        result += base.map { "  - \($0)" }.joined(separator: "\n")
        return result
    }
}

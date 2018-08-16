//
//  StyledPath.Composite+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import DataStructures
import Geometry
import Path
import Rendering

extension Group {
    
    init(_ svgGroup: SVG.Group) {
        self.init(svgGroup.identifier)
    }
}

// TODO: Use extension StyledPath.Composite when Swift allows it
// TODO: Refactor to keep DRY.
extension Tree where Branch == Group, Leaf == Item {
    
    /// Creates a `StyledPath.Composite` with the given `svg`.
    public init(_ svg: SVG) {
        
        // Transform SVG structure in StyledPath.Composite
        let structure: StyledPath.Composite = .init(svg.structure)

        // Normalize frame
        // TODO: Move this all to StyledPath.Composite.init
        // FIXME: Refactor incorporating text
        let boundingBox = structure.leaves
            .map { leaf -> Rectangle in
                switch leaf {
                case .path(let renderedPath):
                    return renderedPath.path.axisAlignedBoundingBox
                }
            }
            .nonEmptySum ?? .zero

        let ref = boundingBox.origin
        let translated = structure.mapLeaves { $0.translated(by: -ref) }
        
        // Create root group
        let frame = Rectangle(size: boundingBox.size)
        let root = Group("root", frame: frame)
        
        // Initialize
        self = .branch(root, [translated])
    }

    /// Creates a `StyledPath.Composite` with the given `svg`, scaled to the given `height`.
    public init(_ svg: SVG, height: Double) {

        // Transform SVG structure in StyledPath.Composite
        let structure: StyledPath.Composite = .init(svg.structure)

        // Normalize frame
        // TODO: Move this all to StyledPath.Composite.init
        // FIXME: Refactor incorporating text
        let boundingBox = structure.leaves
            .map { leaf -> Rectangle in
                switch leaf {
                case .path(let renderedPath):
                    return renderedPath.path.axisAlignedBoundingBox
                }
            }
            .nonEmptySum ?? .zero

        let proportion = height / boundingBox.size.height
        let ref = boundingBox.origin

        let translated = structure.mapLeaves { leaf -> Item in
            switch leaf {
            case .path(let renderedPath):
                return .path(renderedPath
                    .translated(by: -proportion * ref)
                    .scaled(by: proportion))
            }
        }

        // Create root group
        let scaledBoundingBox = boundingBox.scaled(by: proportion, around: .origin)
        let frame = Rectangle(size: scaledBoundingBox.size)
        let root = Group("root", frame: frame)

        // Initialize
        self = .branch(root, [translated])
    }

    /// Creates a `StyledPath.Composite` with the given `svg`, scaled to the given `width`.
    public init(_ svg: SVG, width: Double) {

        // Transform SVG structure in StyledPath.Composite
        let structure: StyledPath.Composite = .init(svg.structure)

        // Normalize frame
        // TODO: Move this all to StyledPath.Composite.init
        // FIXME: Refactor incorporating text
        let boundingBox = structure.leaves
            .map { leaf -> Rectangle in
                switch leaf {
                case .path(let renderedPath):
                    return renderedPath.path.axisAlignedBoundingBox
                }
            }
            .nonEmptySum ?? .zero
        
        let proportion = width / boundingBox.size.height
        let ref = boundingBox.origin

        let translated = structure.mapLeaves { leaf -> Item in
            switch leaf {
            case .path(let renderedPath):
                return .path(renderedPath
                    .translated(by: -proportion * ref)
                    .scaled(by: proportion))
            }
        }

        // Create root group
        let scaledBoundingBox = boundingBox.scaled(by: proportion, around: .origin)
        let frame = Rectangle(size: scaledBoundingBox.size)
        let root = Group("root", frame: frame)

        // Initialize
        self = .branch(root, [translated])
    }

    internal init(_ svg: SVG.Structure) {
        switch svg {
        case .leaf(let renderedPath):
            self = .leaf(.path(renderedPath))
        case .branch(let group, let trees):
            let group = Group(group)
            self = .branch(group, trees.map { .init($0) })
        }
    }
}

#endif

//
//  SVG.swift
//  Rendering
//
//  Created by James Bean on 6/16/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import Foundation
import DataStructures
import Geometry
import Path
import Rendering

public struct SVG {
    
    // Map names to shape types which can be initialized by an svg element, and can
    // be represented as `Path` values.
    static let shapesByName: [String: (SVGInitializable & PathRepresentable).Type] = [
        "line": Line.Segment.self,
        "polyline": Polyline.self,
        "rect": Rectangle.self,
        "circle": Circle.self,
        "ellipse": Ellipse.self,
        "polygon": Polygon.self
    ]
    
    /// Composite structure of `SVG.Group` values containing `StyledPath` values.
    public typealias Structure = Tree<Group,StyledPath>
    
    /// View rectangle.
    public let viewBox: Rectangle
    
    /// Composite structure composed of `RenderedPath` values.
    public let structure: Structure
    
    // MARK: - Initializers
    
    /// Creates an `SVG` model with the given `viewBox` and `structure`.
    public init(viewBox: Rectangle, structure: Structure) {
        self.viewBox = viewBox
        self.structure = structure
    }
    
    /// Creates an `SVG` model for a file at the given `url`.
    public init(url: URL) throws {
        let parser = try Parser(url: url)
        self = try parser.parse()
    }
    
    /// Creates an `SVG` model for a file with the given `name` in the resources bundle.
    public init(name: String) throws {
        let parser = try Parser(name: name)
        self = try parser.parse()
    }
}

#endif

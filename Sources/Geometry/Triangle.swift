//
//  Triangle.swift
//  Path
//
//  Created by James Bean on 6/5/17.
//
//

import Darwin
import DataStructures

/// Model of a triangle.
public struct Triangle: ConvexPolygonProtocol {

    /// Points comprising `Triangle`.
    public var points: (p1: Point, center: Point, p2: Point) {
        return (p1: vertices[0], center: vertices[1], p2: vertices[2])
    }

    // MARK: - Instance Properties

    /// - Returns: The angle of `Triangle`.
    public var angle: Angle {

        let (p1, center, p2) = points
        let a = pow(center.x - p1.x, 2) + pow(center.y - p1.y, 2)
        let b = pow(center.x - p2.x, 2) + pow(center.y - p2.y, 2)
        let c = pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2)

        return Angle(radians: acos((a + b - c) / sqrt(4 * a * b)))
    }

    public var crossProduct: Double {
        return Geometry.crossProduct(vertices[0], vertices[1], vertices[2])
    }

    /// Vertices contained herein.
    public let vertices: VertexCollection

    // MARK: - Initializers

    /// Create a `Triangle` with the given three vertices.
    public init(_ a: Point, _ b: Point, _ c: Point) {
        self.vertices = [a,b,c]
    }

    /// Create a `Triangle` with the given vertices.
    ///
    /// - Warning: Will crash if given more or less than three vertices!
    ///
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {

        let vertices = VertexCollection(vertices)

        guard vertices.count == 3 else {
            fatalError("A triangle must have three vertices!")
        }

        self.vertices = vertices
    }

    /// - Returns: `true` if `Triangle` is convex for the given `rotation`. Otherwise, `false`.
    public func isConvex(rotation: Rotation) -> Bool {
        switch rotation {
        case .counterClockwise:
            return crossProduct < 0 ? true : false
        case .clockwise:
            return crossProduct < 0 ? false : true
        }
    }

    /// - Returns: `true` if `Triangle` contains the given `point` in its area.
    public func contains(_ point: Point) -> Bool {

        // zCrossProduct, then sign
        func sign(a: Point, b: Point, c: Point) -> FloatingPointSign {
            return ((a.x - c.x) * (b.y - c.y) - (b.x - c.x) * (a.y - c.y)).sign
        }

        let b1 = sign(a: point, b: vertices[0], c: vertices[1])
        let b2 = sign(a: point, b: vertices[1], c: vertices[2])
        let b3 = sign(a: point, b: vertices[2], c: vertices[0])

        return (b1 == b2) && (b2 == b3)
    }
}

extension Triangle: Equatable {

    // MARK: - Equatable

    /// - Returns: `true` if both `Triangle` values are equivalent. Otherwise, `false`.
    public static func == (lhs: Triangle, rhs: Triangle) -> Bool {
        return lhs.vertices == rhs.vertices
    }
}

internal func crossProduct(_ a: Point, _ b: Point, _ c: Point) -> Double {
    return ((a.x * (c.y - b.y)) + (b.x * (a.y - c.y)) + (c.x * (b.y - a.y)))
}

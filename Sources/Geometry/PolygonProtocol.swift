//
//  PolygonProtocol.swift
//  Path
//
//  Created by James Bean on 6/6/17.
//
//

import Math

/// Interface for polygonal shapes.
public protocol PolygonProtocol: Shape {

    // MARK: - Instance Properties

    /// Circular collection of vertices comprising `PolygonProtocol`.
    var vertices: VertexCollection { get }

    /// `ConvexPolygonContainer` created for testing collisions.
    var collisionDetectable: ConvexPolygonContainer { get }

    // MARK: - Initializers

    /// Create a `PolygonProtocol`-conforming type with the given sequence of `vertices`.
    init <S: Sequence> (vertices: S) where S.Iterator.Element == Point

    // MARK: - Instance Methods

    /// - Returns: `true` if a `PolygonProtocol` contains the given `point`.
    func contains(_ point: Point) -> Bool
}

extension PolygonProtocol {

    /// - returns: Array of the line values comprising the edges of the `PolygonProtocol`-
    /// conforming type.
    public var edges: [Line.Segment] {
        return vertices.edges
    }

    /// - Returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    internal var axes: [Vector2] {
        return vertices.axes
    }

    /// - Returns: Whether vertices are arranged clockwise / counterclockwise.
    public var rotation: Rotation {
        return vertices.rotation
    }

    /// - Returns: Array of triangles created with each adjacent triple of vertices.
    public var triangles: [Triangle] {
        return vertices.triangles
    }

    /// - Returns: Array of the angles.
    public var angles: [Angle] {
        return vertices.angles
    }

    /// - Returns: `true` if a `PolygonProtocol` contains the given `point`.
    public func contains(_ point: Point) -> Bool {

        /// - Returns: The horizontal position of the intersection of horizontal ray shooting
        /// from the given `point` through the given `edge`, if it exists. Otherwise, `nil`.
        func intersection(ofHorizontalRayFrom point: Point, through edge: Line.Segment)
            -> Double?
        {
            return edge.x(y: point.y)
        }

        return edges.lazy

            // All of the points of the horizontal ray eminating from the point
            .compactMap { edge in intersection(ofHorizontalRayFrom: point, through: edge) }

            // Only look at the points to the left
            .filter { $0 < point.x }

            // If the amount of intersection points to the left is odd, we contain the point
            .count.isOdd
    }

    /// - Returns: `true` if a `PolygonProtocol` contains any of the the given `points`.
    public func contains(anyOf points: [Point]) -> Bool {
        for point in points where contains(point) {
            return true
        }
        return false
    }

    /// - Returns: A `Set` of all of the y-values at the given `x`.
    public func ys(at x: Double) -> Set<Double> {
        return Set(edges.compactMap { edge in edge.y(x: x) })

    }

    /// - Returns: A `Set` of all of the x-values at the given `y`.
    public func xs(at y: Double) -> Set<Double> {
        return Set(edges.compactMap { edge in edge.x(y: y) })
    }
}

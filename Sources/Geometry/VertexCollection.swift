//
//  VertexCollection.swift
//  Path
//
//  Created by James Bean on 6/7/17.
//
//

import DataStructures
import Math

/// Circular collection of `Point` values.
public typealias VertexCollection = CircularArray<Point>

// FIXME: One day, we will be able to say: `extension VertexCollection`.
extension CircularArray where Element == Point {

    /// - Returns: The convex hull, or envelope, of `VertexCollection`.
    /// - Note: Uses Gift Wrapping algorithm.
    public var convexHull: VertexCollection {

        // Creates a half-hull of the given `vertices`.
        func halfHull(of vertices: VertexCollection) -> [Point] {

            // Removes the illegitimate vertices from the hull.
            func dropVertices(from hull: [Point], point: Point) -> [Point] {

                // Ensure that we can construct a triangle from the penultimate and last
                // vertices from the hull, along with the given `point`.
                // If the triangle is convex, we keep it, adding the `point` to the
                // accumulating hull.
                guard
                    let penultimate = hull.penultimate,
                    let last = hull.last,
                    crossProduct(penultimate, last, point) >= 0
                else {
                    return hull + point
                }

                // If there are still more vertices left in the hull
                return dropVertices(from: Array(hull.dropLast()), point: point)
            }

            // Adds the point at the given `index` of the given `vertices` to the given `hull`
            // if, when added to the accumulating vertices in the `hull` creates a convex
            // triangle. Otherwise, no point is added, and the vertex at the next index is
            // attempted.
            func addPoint(at index: Int, of vertices: VertexCollection, to hull: [Point])
                -> [Point]
            {

                // Base case: We have reached the end, and have succssfully populated the hull
                guard index < vertices.count else {
                    return hull
                }

                // Drop the illegitimate vertices from the hull, with the current vertex.
                let hull = dropVertices(from: hull, point: vertices[index])

                // Proceed to the next
                return addPoint(at: index + 1, of: vertices, to: hull)
            }

            return addPoint(at: 0, of: vertices, to: [])
        }

        /// A triangle is convex by nature.
        guard count > 3 else { return self }

        // Sort vertices lexicographically (first by x, then by y if necessary)
        let vertices = sorted { $0.x < $1.x || ($0.x == $1.x && $0.y < $1.y) }

        // Assemble the lower half of the hull.
        let lower = halfHull(of: vertices)

        // Assemble the upper half of the hull (approaching the vertices from the reverse).
        let upper = halfHull(of: VertexCollection(vertices.reversed()))

        // Chop off the last element of each, as these elements dovetail.
        let hull = lower.dropLast() + upper.dropLast()

        // And we are done!
        return VertexCollection(hull)
    }

    /// - returns: Array of the line values comprising the edges of the `PolygonProtocol`-
    /// conforming type.
    public var edges: [Line.Segment] {
        return indices.map { index in
            Line.Segment(points: self[from: index, through: index + 1])
        }
    }

    /// - Returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    public var axes: [Vector2] {
        return edges.map { $0.vector }
    }

    /// - Returns: Array of triplets of points created with each.
    ///
    /// FIXME: Consider implementing `triples` over `Sequence`, à la `pairs`.
    public var triples: [Point.Triple] {
        return indices.map { index in triple(self[from: index - 1, through: index + 1]) }
    }

    /// - Returns: Array of the angles of each adjacent triple of vertices.
    public var angles: [Angle] {
        return triples.map(angle)
    }

    /// - Returns: `true` if the vertices contained herein form a convex polygon. Otherwise,
    /// `false`.
    public var formConvexPolygon: Bool {
        return triples.lazy.map(crossProduct).map { $0.sign }.isHomogeneous
    }

    /// - Returns: Wheter vertices are arranged in a clockwise or counterclockwise fasion.
    public var rotation: Rotation {
        let sum = edges.reduce(Double(0)) { accum, cur in
            let (a,b) = (cur.start, cur.end)
            return accum + (b.x - a.x) * (b.y + a.y)
        }
        return sum > 0 ? .clockwise : .counterClockwise
    }
}

//
//  Polygon.swift
//  Path
//
//  Created by James Bean on 6/5/17.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import DataStructures
import Algorithms
import Algebra

/// Polgonal shape containing at least three vertices.
public struct Polygon: PolygonProtocol {

    /// - Returns: `ConvexPolygonContainer` that can be used for collision detection.
    ///
    /// - Note: In the case that this `Polygon` is convex, the `ConvexPolygonContainer` is
    /// initialized with it. In the case the this `Polygon` is concave, it is broken up into
    /// the minimum number of triangles through an Ear Clipping method.
    public var collisionDetectable: ConvexPolygonContainer {
        return isConvex
            ? ConvexPolygonContainer(ConvexPolygon(vertices: vertices))
            : ConvexPolygonContainer(triangulated)
    }

    /// Triangulate counter-clockwise `Polygon`.
    ///
    /// - Note: Uses Ear Clipping method to split concave polygon into array of `Triangle`
    /// values.
    internal var triangulated: [Triangle] {

        /// - Returns: `true` if the given `triangle` is valid for clipping off.
        ///
        /// A triangle is valid for cipping if it satisfies two requirements:
        ///
        /// - It is convex, given the order of traversal.
        /// - There are no remaining vertices contained within its area.
        ///
        func isEar(_ triple: Point.Triple, remainingVertices: [Point]) -> Bool {
            guard Geometry.isConvex(triple, traversing: .counterClockwise) else { return false }
            guard !Triangle(triple).contains(anyOf: remainingVertices) else { return false }
            return true
        }

        /// - Returns: A triangle, if valid for clipping. Otherwise, `nil`.
        func ear(at index: Int, of vertices: VertexCollection) -> Triangle? {
            let t = triple(vertices[from: index - 1, through: index + 1])
            let remainingVertices = vertices[after: index + 1, upTo: index - 1]
            return isEar(t, remainingVertices: remainingVertices) ? Triangle(t) : nil
        }

        /// Attempts to clip off an ear at the given `index`, from the given `vertices`.
        /// If we are able to do so, we snip off the tip, and drop the ear into `ears`.
        /// Otherwise, we move on to the next vertex.
        ///
        /// - Returns: Array of `Triangle` values that cover the same area as `Polygon`.
        ///
        func clipEar(at index: Int, from vertices: VertexCollection, into ears: [Triangle])
            -> [Triangle]
        {

            // Base case: If there are only three vertices left, we have the last triangle!
            guard vertices.count > 3 else {
                return ears + Triangle(vertices: vertices[from: index - 1, through: index + 1])
            }

            // If no ear found at current index, continue on to the next vertex.
            guard let ear = ear(at: index, of: vertices) else {
                return clipEar(at: index + 1, from: vertices, into: ears)
            }

            // Snip off tip, and proceed.
            #warning("VertexCollection has no `removing(at:)`, refine")
            var v = vertices
            v.remove(at: index)

            return clipEar(at: index, from: v, into: ears + ear)
        }

        /// Ensure that the vertices are ordered in a counter-clockwise fasion.
        /// Traverse a circular view of the vertices to allow the wrapping around its end.
        return clipEar(at: 0, from: counterClockwise.vertices, into: [])
    }

    /// - Returns: Convex hull of vertices in `Polygon`.
    public var convexHull: Polygon {
        return Polygon(vertices: vertices.convexHull)
    }

    /// View of `Polygon` in which the vertices are ordered in a clockwise fashion.
    internal var clockwise: Polygon {
        return rotation == .clockwise ? self : Polygon(vertices: vertices.reversed())
    }

    /// View of `Polygon` in which the vertices are ordered in a counter-clockwise fashion.
    internal var counterClockwise: Polygon {
        return rotation == .counterClockwise ? self : Polygon(vertices: vertices.reversed())
    }

    /// - Returns: `true` if `Polygon` is convex. Otherwise, `false`.
    internal var isConvex: Bool {
        return vertices.formConvexPolygon
    }

    /// Vertices contained herein.
    public let vertices: VertexCollection

    // MARK: - Initializers

    /// Creates a `Polygon` with the given `vertices`.
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {
        self.vertices = VertexCollection(vertices)
    }

    /// Create a unconstrained `Polygon` from any `PolygonProtocol`-conforming type.
    public init(_ polygon: PolygonProtocol) {
        self.vertices = polygon.vertices
    }
}

extension Polygon: Additive {
    
    /// Empty polygon.
    public static let zero = Polygon(vertices: [])

    /// Creates union of two given `Polygon` values.
    public static func + (lhs: Polygon, rhs: Polygon) -> Polygon {
        return Polygon(vertices: (lhs.vertices + rhs.vertices).convexHull)
    }
}

extension Polygon: Equatable { }

extension Polygon: CustomStringConvertible {

    // MARK: CustomStringConvertible

    /// Print the vertices in order of their appearance
    public var description: String {
        return "Polygon<\(vertices.count)>[" + vertices.map { "\($0)" }.joined(separator: ", ") + "]"
    }
}

extension Point {
    public typealias Triple = (Point,Point,Point)
}

/// - Returns: A triple of points from the given array.
///
/// - Warning: There must be 3 points in the given `vertices`
func triple(_ vertices: [Point]) -> Point.Triple {
    return (vertices[0],vertices[1],vertices[2])
}

/// - Returns: The `Angle` of the given `vertices`, with the second of the triple being the point
/// of reference.
func angle(_ vertices: Point.Triple) -> Angle {
    let (p1, center, p2) = vertices
    let a = pow(center.x - p1.x, 2) + pow(center.y - p1.y, 2)
    let b = pow(center.x - p2.x, 2) + pow(center.y - p2.y, 2)
    let c = pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2)
    return Angle(radians: acos((a + b - c) / sqrt(4 * a * b)))
}

func isConvex(_ triplet: Point.Triple, traversing rotation: Rotation) -> Bool {
    let cp = crossProduct(triplet)
    return rotation == .clockwise ? cp > 0 : cp < 0
}

private func crossProduct(_ triplet: Point.Triple) -> Double {
    let (a,b,c) = triplet
    return ((a.x * (c.y - b.y)) + (b.x * (a.y - c.y)) + (c.x * (b.y - a.y)))
}

extension Triangle {
    init(_ triple: Point.Triple) {
        self.init(triple.0,triple.1,triple.2)
    }
}

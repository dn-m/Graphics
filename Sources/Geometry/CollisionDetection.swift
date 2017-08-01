//
//  CollisionDetection.swift
//  Path
//
//  Created by James Bean on 6/6/17.
//
//

import Math

/// - Returns: `true` if any convex polygons of one `CollisionDetectable`-conforming type
/// intersect with another. Otherwise, `false`.
public func collision(_ a: CollisionDetectable, _ b: CollisionDetectable) -> Bool {

    for a in a.collisionDetectable.polygons {
        for b in b.collisionDetectable.polygons {
            if collision(a,b) {
                return true
            }
        }
    }

    return false
}

/// - Returns: `true` if the axes of either shape overlap with those of the other. Otherwise,
/// `false`.
///
/// - Note: Uses the `Separating Axis Theorem` to determine whether or not the convex polygonal
/// shapes intersect.
///
func collision(_ a: ConvexPolygonProtocol, _ b: ConvexPolygonProtocol) -> Bool {
    return axesOverlap(projecting: a, onto: b) && axesOverlap(projecting: b, onto: a)
}

/// - Returns: `false` if there are _any_ spaces between the range projected by the given
/// `other` shape onto the axes of the given `shape`. Otherwise, `true`.
func axesOverlap(projecting other: ConvexPolygonProtocol, onto shape: ConvexPolygonProtocol)
    -> Bool
{
    // Project `shape` and `other` onto each axis of `shape`.
    for axis in shape.axes {

        // If we ever see light between two shapes, we short-circuit to `false`
        if !axesOverlap(project(shape, onto: axis), project(other, onto: axis)) {
            return false
        }
    }

    // All pairs of axes overlapped.
    return true
}

/// - Returns: `true` if there is any overlap between the two given ranges. Otherwise, `false`.
func axesOverlap(_ a: (min: Double, max: Double), _ b: (min: Double, max: Double)) -> Bool {
    return !(a.min > b.max || b.min > a.max)
}

// MARK: Collision Detection: Separating Axis Theorem

/// - Returns: The `min` and `max` values of the given `shape` projected on the given `axis`.
func project(_ shape: ConvexPolygonProtocol, onto axis: Vector2)
    -> (min: Double, max: Double)
{

    let length = axis.length

    let values = shape.vertices.map { vertex in
        vertex.x * (axis.x / length) + vertex.y * (axis.y / length)
    }

    return (values.min()!, values.max()!)
}

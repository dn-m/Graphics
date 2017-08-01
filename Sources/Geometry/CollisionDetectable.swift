//
//  CollisionDetectable.swift
//  Path
//
//  Created by James Bean on 6/7/17.
//
//

/// Interface for shapes which can be checked for collisions.
public protocol CollisionDetectable {

    /// `ConvexPolygonContainer` usable for checking collisions between all types of polygons.
    var collisionDetectable: ConvexPolygonContainer { get }
}

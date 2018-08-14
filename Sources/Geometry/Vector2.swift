//
//  Vector2.swift
//  Graphics
//
//  Created by James Bean on 6/7/17.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

/// Two-dimensional Vector.
public struct Vector2 {

    // MARK: - Instance Properties

    /// Length of a `Vector2`
    public var length: Double {
        return hypot(x,y)
    }

    /// X value.
    public let x: Double

    /// Y value.
    public let y: Double

    // MARK: - Initializers

    /// Creates a `Vector2` with the given `x` and `y` values.
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    /// Creates a `Vector2` with two `Point` values.
    public init(_ a: Point, _ b: Point) {
        self.init(x: b.x - a.x, y: b.y - a.y)
    }
}

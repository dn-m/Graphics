//
//  Line.Segment.swift
//  Graphics
//
//  Created by James Bean on 6/19/17.
//
//

import Structure

extension Line {

    /// Model of line segment.
    public struct Segment {

        // MARK: - Type Properties

        public static func horizontal(at y: Double) -> Segment {
            return Segment(
                start: Point(x: .leastNormalMagnitude, y: y),
                end: Point(x: .greatestFiniteMagnitude, y: y)
            )
        }

        public static func vertical(at x: Double) -> Segment {
            return Segment(
                start: Point(x: x, y: .leastNormalMagnitude),
                end: Point(x: x, y: .greatestFiniteMagnitude)
            )
        }

        // MARK: - Instance Properties

        /// Vector of `Line`.
        public var vector: Vector2 {
            return Vector2(x: end.x - start.x, y: end.y - start.y)
        }

        /// Length of `Line`.
        public var length: Double {
            return vector.length
        }

        /// Slope.
        public var slope: Double {
            return (end.y - start.y) / (end.x - start.x)
        }

        /// Start point.
        public let start: Point

        /// End point.
        public let end: Point

        // MARK: - Initializers

        /// Creates a `Line` with the given `start` and `end` points.
        public init(start: Point, end: Point) {
            self.start = start
            self.end = end
        }

        /// Create a `Line` with an array of `points`.
        ///
        /// - Warning: Will crash if given an array whose `count` is not two.
        ///
        public init(points: [Point]) {

            guard points.count == 2 else {
                fatalError("A line must have two vertices!")
            }

            self.start = points[0]
            self.end = points[1]
        }

        // MARK: - Instance Methods

        /// - Returns: Vertical position for the given horizontal position, if it exists.
        /// Otherwise, `nil`.
        public func y(x: Double) -> Double? {

            // Ensure line is positive
            let (a,b,_) = ensuring(start, end) { start.x <= end.x }

            // Ensure x value is in domain
            guard (a.x...b.x).contains(x) else {
                return nil
            }

            return x * (b.y - a.y) / (b.x - a.x) + a.y
        }

        /// - Returns: Horizontal position for the given vertical position, if it exists.
        /// Otherwise, `nil`.
        public func x(y: Double) -> Double? {

            // Ensure line is positive
            let (a,b,_) = swapped(start,end) { start.y > end.y }

            // Ensure y value is in range of line
            guard (a.y...b.y).contains(y) else {
                return nil
            }

            return (b.x - a.x) * (y - a.y) / (b.y - a.y) + a.x
        }
    }
}

/// - returns: If the given `predicate` is `false`, a tuple of `(b, a, true)`
/// Otherwise, `(a, b, false)`
private func ensuring <T> (_ a: T, _ b: T, that predicate: () -> Bool) -> (T, T, Bool) {
    return predicate() ? (a, b, false) : (b, a, true)
}

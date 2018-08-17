//
//  BezierCurve.swift
//  Path
//
//  Created by James Bean on 11/24/16.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Algorithms
import Math
import Geometry

/// Model of a Bézier curve.
public struct BezierCurve {
    
    // MARK: - Instance Properties
    
    /// - TODO: Consider making `func` with `accuracy` parameter.
    public var axisAlignedBoundingBox: Rectangle {
        switch order {
        case .linear:
            let minX = min(points[0].x, points[1].x)
            let minY = min(points[0].y, points[1].y)
            let maxX = max(points[0].x, points[1].x)
            let maxY = max(points[0].y, points[1].y)
            let width = maxX - minX
            let height = maxY - minY
            return Rectangle(x: minX, y: minY, width: width, height: height)
        default:
            let (first,rest) = simplified(segmentCount: 10).destructured!
            var minX = first.x
            var minY = first.y
            var maxX = first.x
            var maxY = first.y
            for point in rest {
                if point.x < minX { minX = point.x }
                if point.x > maxX { maxX = point.x }
                if point.y < minY { minY = point.y }
                if point.y > maxY { maxY = point.y }
            }
            let width = maxX - minX
            let height = maxY - minY
            return Rectangle(x: minX, y: minY, width: width, height: height)
        }
    }
    
    /// Order of `BezierCurve`.
    public var order: Order {

        guard let order = Order(rawValue: points.count) else {
            fatalError("Somehow you have managed to create an unsupported Bézier curve!")
        }
        
        return order
    }
    
    /// Start point.
    public var start: Point {
        return points.first!
    }
    
    /// End point.
    public var end: Point {
        return points.last!
    }
    
    /// Arc length of `BezierCurve`.
    ///
    /// - TODO: Add customizability to accuracy.
    ///
    public var length: Double {
        switch order {
        case .linear:
            return Line.Segment(points: points).length
        case .quadratic, .cubic:
            return stride(from: 0, through: 1, by: 0.01).lazy
                .map { t in self[t] }
                .pairs.map(Line.Segment.init)
                .map { $0.length }
                .sum
        }
    }

    /// The control points defining a Bézier curve.
    public let points: [Point]
}

extension BezierCurve {

    // MARK: - Initializers

    /// Creates a linear `BezierCurve` with the given `start` and `end` points.
    public init(start: Point, end: Point) {
        self.points = [start, end]
    }

    /// Creates a linear `BezierCurve` with the given `line`.
    public init(_ line: Line.Segment) {
        self.init(start: line.start, end: line.end)
    }

    /// Creates a quadratic `BezierCurve` with the given `start`, `control` and `end` points.
    public init(start: Point, control: Point, end: Point) {
        self.points = [start, control, end]
    }

    /// Creates a cubic `BezierCurve` with the given `start`, control and `end` points.
    public init(start: Point, control1: Point, control2: Point, end: Point) {
        self.points = [start, control1, control2, end]
    }

    /// Creates a `BezierCurve` with the given points.
    internal init(_ points: [Point]) {

        guard (2...4).contains(points.count) else {
            fatalError("Bézier curves with \(points.count) control points not supported!")
        }

        self.points = points
    }
}

extension BezierCurve {

    // MARK: - Subscripts

    /// - Returns: `Point` at the given `t` value.
    public subscript (t: Double) -> Point {
        switch order {
        case .linear:
            return t * (end - start) + start
        case .quadratic:
            let control = points[1]
            return start * pow(1-t, 2) + control * 2 * (1-t) * t + end * pow(t,2)
        case .cubic:
            let control1 = points[1]
            let control2 = points[2]
            return (
                start * pow(1-t, 3) +
                control1 * 3 * pow(1-t, 2) * t +
                control2 * 3 * (1-t) * pow(t,2) +
                end * pow(t,3)
            )
        }
    }
}

extension BezierCurve {

    // MARK: - Instance Methods

    /// - Returns: `t` values for the given `x`.
    public func ts(x: Double) -> Set<Double> {
        switch order {
        case .linear:
            return [(x - start.x) * (end.x - start.x)]
        case .quadratic:
            let c = start
            let b = 2 * (points[1] - start)
            let a = start - 2 * points[1] + end
            return quadratic(a.x, b.x, c.x - x)
        case .cubic:
            return cardano(points: points, line: .vertical(at: x))
        }
    }

    /// - Returns: `t` values for the given `y`.
    public func ts(y: Double) -> Set<Double> {
        switch order {
        case .linear:
            return [(y - start.y) * (end.y - start.y)]
        case .quadratic:
            let c = start
            let b = 2 * (points[1] - start)
            let a = start - 2 * points[1] + end
            return quadratic(a.y, b.y, c.y - y)
        case .cubic:
            return cardano(points: points, line: .horizontal(at: y))
        }
    }

    /// - Returns: Vertical positions for the given `x`.
    public func ys(x: Double) -> Set<Double> {
        switch order {
        case .linear:
            return [start.y + ((x - start.x) / (end.x - start.x)) * (end.y - start.y)]
        case .quadratic, .cubic:
            return Set(ts(x: x).map { t in self[t].y })
        }
    }

    /// - Returns: Horizontal positions for the given `y`.
    public func xs(y: Double) -> Set<Double> {
        switch order {
        case .linear:
            return [start.x + ((y - start.y) / (end.y - start.y)) * (end.x - start.x)]
        case .quadratic, .cubic:
            return Set(ts(y: y).map { t in self[t].x })
        }
    }

    /// - Returns: `BezierCurve` translated by the given `point`.
    public func translated(by point: Point) -> BezierCurve {
        return BezierCurve(points.map { $0.translated(by: point) })
    }

    /// - Returns: `BezierCurve` translated by the given `x` and `y` values.
    public func translatedBy(x: Double = 0, y: Double = 0) -> BezierCurve {
        return translated(by: Point(x: x, y: y))
    }

    /// - Returns: Two `BezierCurve` values of the same order as `self`, split at the given `t`
    /// value.
    public func split(t: Double) -> (BezierCurve, BezierCurve) {
        return map(splitCurve(controlPoints: points, at: t)) { BezierCurve($0) }
    }

    /// - Returns: Array of `Point` values.
    public func simplified(segmentCount: Int) -> [Point] {
        if order == .linear { return [start, end] }
        let segment = 1 / Double(segmentCount)
        return stride(from: 0, through: 1, by: segment).map { t in self[t] }
    }

    /// - Returns: `BezierCurve` which is scaled by the given `amount` from the given
    /// `reference` point.
    public func scaled(by amount: Double, from reference: Point = Point()) -> BezierCurve {
        return BezierCurve(points.map { $0.scaled(by: amount, from: reference) })
    }

    /// - Returns: `BezierCurve` which is rotated by the given `angle` around the given
    /// `reference` point.
    public func rotated(by angle: Angle, around reference: Point = Point()) -> BezierCurve {
        return BezierCurve(points.map { $0.rotated(by: angle, around: reference) })
    }
}

extension BezierCurve {

    // MARK: - Nested Types

    /// Order of `BezierCurve`.
    public enum Order: Int {
        case linear = 2
        case quadratic = 3
        case cubic = 4
    }
}

extension BezierCurve: Equatable { }

extension BezierCurve: CustomStringConvertible {

    public var description: String {
        switch order {
        case .linear:
            return "Line: \(points[0]) -> \(points[1])"
        case .quadratic:
            return "Quad: \(points[0]) -> \(points[1]) -> \(points[2]))"
        case .cubic:
            return "Cube: \(points[0]) -> \(points[1]) -> \(points[2]) -> \(points[3]))"
        }
    }
}

/// - Returns: Splits an arbitrarily-highly-ordered Bezier curve at the given `t` value into two
/// paths of the same order.
func splitCurve(controlPoints: [Point], at t: Double) -> ([Point], [Point]) {

    func split(points: [Point], at t: Double, into left: [Point], and right: [Point])
        -> ([Point], [Point])
    {
        guard points.count > 1 else { return (left + [points.first!], right + [points.first!]) }
        let left = left + [points.first!]
        let right = right + [points.last!]
        let points = points.pairs.map { (a: Point, b: Point) -> Point in (1-t) * a + t * b }
        return split(points: points, at: t, into: left, and: right)
    }
    return split(points: controlPoints, at: t, into: [], and: [])
}

extension Array {
    // Given sequence of 2-tuples, return two arrays
    func unzip <T,U> () -> ([T],[U]) where Element == (T,U) {
        var t: [T] = []
        var u: [U] = []
        t.reserveCapacity(count)
        u.reserveCapacity(count)
        for (a, b) in self {
            t.append(a)
            u.append(b)
        }
        return (t,u)
    }
}

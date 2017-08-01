//
//  Path.Builder.swift
//  Path
//
//  Created by James Bean on 6/11/17.
//
//

import Geometry

/// Interface exposed upon beginning the `Path` step-building pattern, or after a subPath has
/// been closed.
public protocol AllowingMoveTo {
    
    @discardableResult
    func move(to point: Point) -> AllowingAllPathElements
    
    @discardableResult
    func addCurve(_ curve: BezierCurve) -> AllowingAllPathElements
}

/// Interface exposed (along with `ExposesMoveTo`) after adding a `close()` element.
public protocol AllowingBuild {
    
    @discardableResult
    func build() -> Path
}

/// Interface exposing all possible path element build steps.
public protocol AllowingAllPathElements: AllowingMoveTo, AllowingBuild {
    
    @discardableResult
    func addLine(to point: Point) -> AllowingAllPathElements
    
    @discardableResult
    func addQuadCurve(to point: Point, control: Point) -> AllowingAllPathElements
    
    @discardableResult
    func addCurve(to point: Point, control1: Point, control2: Point) -> AllowingAllPathElements
    
    @discardableResult
    func close() -> AllowingBuild & AllowingMoveTo
}

extension Path {
    
    // MARK: - Type Properties
    
    /// - Returns: `Builder` object that only exposes the `move(to:)` method, as it is a
    /// required first element for a `Path`.
    public static var builder: AllowingMoveTo {
        return Builder()
    }
    
    private final class Builder: AllowingAllPathElements {
        
        var subPathFirst: Point!
        var last: Point!
        var curves: [BezierCurve] = []
        
        // MARK: - Initializers
        
        /// Creates a `Path.Builder` ready to build a `Path`.
        init() { }
        
        // MARK: - Instance Methods
        
        /// Move to `point`.
        ///
        /// - Returns: `self`.
        @discardableResult
        func move(to point: Point) -> AllowingAllPathElements {
            last = point
            subPathFirst = point
            return self
        }
        
        /// Add line to `point`.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addLine(to point: Point) -> AllowingAllPathElements {
            let curve = BezierCurve(start: last, end: point)
            curves.append(curve)
            last = point
            return self
        }
        
        /// Add curve to `point`, with a single control point.
        ///
        /// - returns: `self`.
        @discardableResult
        func addQuadCurve(to point: Point, control: Point) -> AllowingAllPathElements {
            let curve = BezierCurve(start: last, control: control, end: point)
            curves.append(curve)
            last = point
            return self
        }
        
        /// Add curve to `point`, with two control points.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addCurve(to point: Point, control1: Point, control2: Point)
            -> AllowingAllPathElements
        {
            let curve = BezierCurve(
                start: last,
                control1: control1,
                control2: control2,
                end: point
            )
            curves.append(curve)
            last = point
            return self
        }
        
        /// Adds the given `curve` to the `Path` being built.
        ///
        /// - Returns: `self`.
        @discardableResult
        func addCurve(_ curve: BezierCurve) -> AllowingAllPathElements {
            curves.append(curve)
            last = curve.end
            return self
        }
        
        /// Close path.
        ///
        /// - returns: `self`.
        @discardableResult
        func close() -> AllowingBuild & AllowingMoveTo {
            let curve = BezierCurve(start: last, end: subPathFirst)
            curves.append(curve)
            last = curve.end
            return self
        }
        
        /// - Returns: `Path` value with the elements constructed thus far.
        ///
        /// - Invariant: The first element must be a `move(Point)` element. This is ensured
        /// by the step-builder interface).
        ///
        /// - Invariant: `close` elements must be followed by a `move(Point)` element, or by
        /// a `quadCurve` or `curve` element. This is ensured by the step-builder interface.
        func build() -> Path {
            return Path(curves)
        }
    }
}

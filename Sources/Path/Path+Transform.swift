//
//  Path+Transform.swift
//  Path
//
//  Created by James Bean on 6/11/16.
//
//

import Geometry

extension Path {
    
    // MARK: - Transforms

    /// - Returns: `Path` scaled by the given `amount` from the given `reference` point.
    public func scaled(by amount: Double, from reference: Point = Point()) -> Path {
        return Path(curves.map { $0.scaled(by: amount, from: reference) })
    }
    
    /// - Returns: `Path` rotated by the given `angle` around the given `reference` point.
    public func rotated(by angle: Angle, around reference: Point = Point()) -> Path {
        return Path(curves.map { $0.rotated(by: angle, around: reference) })
    }

    /// - Returns: `Path` translated by the given `point`.
    public func translated(by point: Point) -> Path {
        return Path(curves.map { $0.translated(by: point) })
    }

    /// - Returns: `Path` translated by the given `x` and `y` values.
    public func translatedBy(x: Double, y: Double) -> Path {
        return translated(by: Point(x: x, y: y))
    }
}

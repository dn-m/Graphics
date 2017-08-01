//
//  Angle.swift
//  Path
//
//  Created by James Bean on 6/6/17.
//
//

import Darwin

public typealias Radians = Double
public typealias Degrees = Double

/// Model of an angle.
public struct Angle {

    /// `Angle` with a value of `0`.
    public static let zero = Angle(radians: 0)

    /// Value in `Radians`.
    public let radians: Radians

    /// Value within -180°...180°.
    public var normalized: Angle {
        return Angle(radians: radians - (2 * .pi) * floor((radians + .pi) / (2 * .pi)))
    }

    /// Value in `Degrees`.
    public var degrees: Degrees {
        return radians * (180.0 / .pi)
    }

    // MARK: - Initializers

    /// Creates an `Angle` with the given `radians` value.
    public init(radians: Radians) {
        self.radians = radians
    }

    /// Creates an `Angle` with the given `degrees` value.
    public init(degrees: Degrees) {
        self.radians = degrees * (.pi / 180)
    }
}

extension Angle: Equatable {

    /// - Returns: `true` if the normalized values of each angle are equivalent. Otherwise,
    /// `false`.
    public static func == (lhs: Angle, rhs: Angle) -> Bool {
        return lhs.normalized.radians == rhs.normalized.radians
    }
}

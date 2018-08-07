//
//  Size.swift
//  Path
//
//  Created by James Bean on 6/3/17.
//
//

import Algebra

/// Model of rectangular size.
public struct Size {

    // MARK: - Instance Properties

    /// Width.
    public let width: Double

    /// Height.
    public let height: Double

    // MARK: - Initializers

    /// Creates a `Size` with the given `width` and `height`.
    public init(width: Double = 0, height: Double = 0) {
        self.width = width
        self.height = height
    }

    /// - Returns: a `Size` with both dimensions scaled by the same value.
    public func scaled(by value: Double) -> Size {
        return Size(width: width * value, height: height * value)
    }

    /// - Returns: a `Size` scaled by the given dimensions.
    public func scaledBy(width widthScale: Double = 1, height heightScale: Double = 1) -> Size {
        return Size(width: width * widthScale, height: height * heightScale)
    }

    /// - Returns: a `Size` scaled by the dimensions of `size`.
    public func scaled(by size: Size) -> Size {
        return scaledBy(width: size.width, height: size.height)
    }
}

extension Size: Zero {

    public static var zero: Size {
        return Size(width: 0, height: 0)
    }
}

extension Size: Equatable { }

/// - Returns: `Size` scaled by the given right-hand-side value.
public func * (lhs: Size, rhs: Double) -> Size {
    return Size(width: lhs.width * rhs, height: lhs.height * rhs)
}

/// - Returns: `Size` scaled by the given left-hand-side value.
public func * (lhs: Double, rhs: Size) -> Size {
    return Size(width: rhs.width * lhs, height: rhs.height * lhs)
}

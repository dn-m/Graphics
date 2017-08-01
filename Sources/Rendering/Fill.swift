//
//  Fill.swift
//  Rendering
//
//  Created by James Bean on 6/15/17.
//
//

/// Configuration for the fill of `Glyph`.
public struct Fill {
    
    // MARK: - Nested Types
    
    /// Winding rule of `Fill`.
    public enum Rule: String {
        case nonZero
        case evenOdd
    }
    
    // MARK: - Instance Properties
    
    /// Color of `Fill`.
    public let color: Color
    
    /// Winding rule of `Fill`.
    public let rule: Rule
    
    // MARK: - Initializers
    
    /// Creates a `Fill` with the given `color` and `rule`.
    public init(color: Color = .black, rule: Rule = .nonZero) {
        self.color = color
        self.rule = rule
    }
}

extension Fill: CustomStringConvertible {

    public var description: String {
        return "\(color), rule: \(rule)"
    }
}

extension Fill.Rule: CustomStringConvertible {

    public var description: String {
        return rawValue
    }
}

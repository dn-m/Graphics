//
//  Stoke.swift
//  Rendering
//
//  Created by James Bean on 6/15/17.
//
//

/// Configuration for the stroke of `Shape`.
public struct Stroke {
    
    // MARK: - Nested Types
    
    /// Dash configuration of `Stroke`.
    public struct Dashes {
        public let pattern: [Double]
        public let phase: Double
    }
    
    /// Style of cap of `Stroke`.
    public enum Cap: String {
        case round
        case butt
        case square
    }
    
    /// Style of join of `Stroke`.
    public enum Join {
        case miter(limit: Double)
        case round
        case bevel
    }
    
    // MARK: - Instance Properties
    
    /// Width.
    public let width: Double
    
    /// Color.
    public let color: Color
    
    /// Join.
    public let join: Join
    
    /// Cap.
    public let cap: Cap
    
    /// Dashes.
    public let dashes: Dashes?
    
    // MARK: - Initializers
    
    /// Creates a `Stroke` with the given `width`, `color`, `join`, `cap`, and `dashes`.
    public init(
        width: Double = 0,
        color: Color = .black,
        join: Join = .miter(limit: 10),
        cap: Cap = .butt,
        dashes: Dashes? = nil
    )
    {
        self.width = width
        self.color = color
        self.join = join
        self.cap = cap
        self.dashes = dashes
    }
}

extension Stroke: CustomStringConvertible {

    public var description: String {
        return "\(width), \(color), join: \(join), cap: \(cap)"
    }
}

extension Stroke.Cap: CustomStringConvertible {

    public var description: String {
        return rawValue
    }
}

extension Stroke.Join: CustomStringConvertible {

    public var description: String {
        switch self {
        case .round:
            return "round"
        case .bevel:
            return "bevel"
        case .miter(let limit):
            return "miter w/ limit: \(limit)"
        }
    }
}

//
//  Line.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Darwin
import Structure
import Math

/// Model of line.
public enum Line {

    case vertical(Double)
    case horizontal(Double)
    case slanted(slope: Double, intercept: Double)

    public init(_ segment: Line.Segment) {

        switch segment.slope {
        case 0:
            self = .horizontal(segment.start.x)
        case Double.nan:
            self = .horizontal(segment.start.x)
        default:
            let intercept = segment.start.y - (segment.slope * segment.start.x)
            self = .slanted(slope: segment.slope, intercept: intercept)
        }
    }

    public init(slope: Double, intercept: Double) {
        self = slope == .infinity
            ? .vertical(.nan)
            : slope == 0
                ? .horizontal(intercept)
                : .slanted(slope: slope, intercept: intercept)
    }

    public func y(x: Double) -> Double {
        switch self {
        case .vertical:
            return Double.nan
        case .horizontal(let y):
            return y
        case let .slanted(slope, intercept):
            return slope == .infinity ? x : slope * x + intercept
        }
    }

    public func perpendicular(containing point: Point) -> Line {
        switch self {
        case .horizontal:
            return .vertical(point.x)
        case .vertical:
            return .horizontal(point.y)
        case let .slanted(slope, _):
            let slope = -1 / slope
            return .slanted(slope: slope, intercept: (slope * -point.x) + point.y)
        }
    }
}

extension Line: Equatable {

    public static func == (lhs: Line, rhs: Line) -> Bool {
        switch (lhs,rhs) {
        case let (.vertical(a), .vertical(b)):
            return a == b
        case let (.horizontal(a), .horizontal(b)):
            return a == b
        case let (.slanted(slopeA, interceptA), .slanted(slopeB, interceptB)):
            return slopeA == slopeB && interceptA == interceptB
        default:
            return false
        }
    }
}

//
//  PathElement.swift
//  Path
//
//  Created by James Bean on 6/10/16.
//
//

import Geometry

/// Element within a `Path`.
public enum PathElement {
    
    public var isVertex: Bool {
        switch self {
        case .move, .line:
            return true
        default:
            return false
        }
    }
    
    /// - Returns: The destination point of `PathElement`.
    public var point: Point? {
        switch self {
        case .move(let point), .line(let point):
            return point
        case .curve(let point, _, _), .quadCurve(let point, _):
            return point
        case .close:
            return nil
        }
    }
    
    /// Move to point.
    case move(Point)

    /// Add line to point.
    case line(Point)

    /// Add quadratic bézier curve to point, with control point.
    case quadCurve(Point, Point)
    
    /// Add cubic bézier curve to point, with two control points.
    case curve(Point, Point, Point)
    
    /// Close subpath.
    case close
    
    func translatedBy(x: Double, y: Double) -> PathElement {
        
        switch self {
            
        case .close:
            return .close
            
        case .move(let point):
            return .move(point.translatedBy(x: x, y: y))
            
        case .line(let point):
            return .line(point.translatedBy(x: x, y: y))
            
        case .quadCurve(let point, let control):
            
            return .quadCurve(
                point.translatedBy(x: x, y: y),
                control.translatedBy(x: x, y: y)
            )
            
        case .curve(let point, let control1, let control2):
            
            return .curve(
                point.translatedBy(x: x, y: y),
                control1.translatedBy(x: x, y: y),
                control2.translatedBy(x: x, y: y)
            )
        }
    }
}

extension PathElement: Equatable { }

extension PathElement: CustomStringConvertible {
    
    public var description: String {
        
        switch self {        
        case .move(let point):
            return "move \(point.x),\(point.y)"
        case .line(let point):
            return "  -> \(point.x),\(point.y)"
        case .quadCurve(let point, let controlPoint):
            return "  ~> \(point.x),\(point.y) via \(controlPoint.x),\(controlPoint.y)"
        case .curve(let point, let controlPoint1, let controlPoint2):
            return "  ~> \(point.x),\(point.y) via \(controlPoint1.x),\(controlPoint1.y) & \(controlPoint2.x),\(controlPoint2.y)"
        case .close:
            return "close"
        }
    }
}

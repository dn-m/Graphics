//
//  PathElement+CGPathElement.swift
//  Path
//
//  Created by James Bean on 1/18/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Geometry
import Path

extension PathElement {
    
    /// Create a `PathElement` with a `CGPathElement`.
    public init(element: CGPathElement) {
        
        switch element.type {
            
        case .moveToPoint:
            self = .move(Point(element.points[0]))
            
        case .addLineToPoint:
            self = .line(Point(element.points[0]))
            
        case .addQuadCurveToPoint:
            self = .quadCurve(Point(element.points[1]), Point(element.points[0]))
            
        case .addCurveToPoint:
            
            self = .curve(
                Point(element.points[2]),
                Point(element.points[0]),
                Point(element.points[1])
            )
            
        case .closeSubpath:
            self = .close
        }
    }
}

#endif

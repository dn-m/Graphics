//
//  Point+CGPoint.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import QuartzCore

extension Point {
    
    /// Creates a `Point` from the given `CGPoint`.
    public init(_ cgPoint: CGPoint) {
        self.init(x: Double(cgPoint.x), y: Double(cgPoint.y))
    }
}

extension CGPoint {
    
    /// Creates a `Point` from the given `CGPoint`.
    public init(_ point: Point) {
        self.init(x: CGFloat(point.x), y: CGFloat(point.y))
    }
}

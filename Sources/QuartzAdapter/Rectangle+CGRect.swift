//
//  Rectangle+CGRect.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import QuartzCore

extension Rectangle {
    
    public init(_ cgRect: CGRect) {
        self.init(origin: Point(cgRect.origin), size: Size(cgRect.size))
    }
}

extension CGRect {
    
    public init(_ rectangle: Rectangle) {
        self.init(origin: CGPoint(rectangle.origin), size: CGSize(rectangle.size))
    }
}

//
//  Rectangle+CGRect.swift
//  Path
//
//  Created by James Bean on 6/3/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Geometry

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

#endif

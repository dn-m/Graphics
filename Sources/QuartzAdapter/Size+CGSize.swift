//
//  Size+CGSize.swift
//  Path
//
//  Created by James Bean on 6/3/17.
//
//

import QuartzCore
import Geometry

extension Size {
    
    public init(_ cgSize: CGSize) {
        self.init(width: Double(cgSize.width), height: Double(cgSize.height))
    }
}

extension CGSize {
    
    public init(_ size: Size) {
        self.init(width: CGFloat(size.width), height: CGFloat(size.height))
    }
}

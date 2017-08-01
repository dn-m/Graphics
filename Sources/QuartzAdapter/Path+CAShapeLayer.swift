//
//  Path+CAShapeLayer.swift
//  PathTools
//
//  Created by James Bean on 6/4/17.
//
//

import QuartzCore

extension CAShapeLayer {
    
    /// Creates a `CAShapeLayer` with the given `path`.
    public convenience init(_ path: Path) {
        self.init()
        self.path = path.cgPath
    }
}

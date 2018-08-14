//
//  Path+CAShapeLayer.swift
//  Path
//
//  Created by James Bean on 6/4/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Path
import Rendering

extension CAShapeLayer {
    
    /// Creates a `CAShapeLayer` with the given `path`.
    public convenience init(_ path: Path) {
        self.init()
        self.path = path.cgPath
    }
}

#endif

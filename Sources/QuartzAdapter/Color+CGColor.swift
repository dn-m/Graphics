//
//  Color+CGColor.swift
//  Rendering
//
//  Created by James Bean on 1/16/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Rendering

extension Color {
    
    public var cgColor: CGColor {
        return CGColor(
            colorSpace: CGColorSpaceCreateDeviceRGB(),
            components: [CGFloat(red), CGFloat(green), CGFloat(blue), CGFloat(alpha)]
        )!
    }
}

#endif

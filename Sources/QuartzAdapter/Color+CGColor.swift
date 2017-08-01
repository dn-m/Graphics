//
//  Color+CGColor.swift
//  Rendering
//
//  Created by James Bean on 1/16/17.
//
//

import QuartzCore
import Rendering

extension Color {
    
    public var cgColor: CGColor {
        return CGColor(
            colorSpace: CGColorSpaceCreateDeviceRGB(),
            components: [
                CGFloat(components.red),
                CGFloat(components.green),
                CGFloat(components.blue),
                CGFloat(components.alpha)
            ]
        )!
    }
}

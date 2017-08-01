//
//  Text.swift
//  Rendering
//
//  Created by James Bean on 6/13/17.
//
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

import Geometry

public struct Text {

    public struct Scale {
        
        public enum Mode {
            
            // Use line height
            case all
            
            // Uses cap height to size when on vertical axis
            case numbersAndUpperCase
        }
        
        public let value: Double
        public let axis: Axis
        public let mode: Mode
        
        public init(to value: Double, axis: Axis, for mode: Mode) {
            self.value = value
            self.axis = axis
            self.mode = mode
        }
    }
    
    public var frame: Rectangle {
        let deltaY = (ascent - capHeight)
        return Rectangle(x: 0, y: -deltaY, width: width, height: height)
    }
    
    // em value in points
    public var em: Double {
        switch scale.axis {
        case .vertical:
            return scale.value / Double(font.capHeight)
        case .horizontal:
            fatalError()
        }
    }
    
    public var descent: Double {
        return Double(font.descent) * em
    }
    
    public var ascent: Double {
        return Double(font.ascent) * em
    }
    
    public var capHeight: Double {
        return Double(font.capHeight) * em
    }
    
    public var height: Double {
        let h = Double(font.unitsPerEm) * em
        return h
    }
    
    public var width: Double {
        #if os(iOS)
            let rect = value.size(
                attributes: [
                    NSFontAttributeName: UIFont(name: fontName, size: CGFloat(fontSize))!
                ]
            )
            return Double(rect.width)
        #elseif os(OSX)
            print("OSX not supported yet!")
            return 0
        #endif
    }
    
    public var fontSize: Double {
        return Double(font.unitsPerEm) * em
    }
    
    public let font: CGFont
    public let fontName: String
    public let value: String
    public let scale: Scale
    public let color: Color
    
    public init(
        _ value: String,
        font fontName: String = "Baskerville-SemiBold",
        height: Double = 24,
        color: Color = .red
    )
    {
        self.fontName = fontName
        self.font = CGFont(fontName as CFString)!
        self.value = value
        self.scale = Scale(to: height, axis: .vertical, for: .numbersAndUpperCase)
        self.color = color
    }
}

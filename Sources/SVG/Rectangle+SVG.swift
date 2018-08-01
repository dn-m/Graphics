//
//  Rectangle+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import Geometry

extension Rectangle: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        
        guard
            let x: Double = svgElement.value(ofAttribute: "x"),
            let y: Double = svgElement.value(ofAttribute: "y"),
            let width: Double = svgElement.value(ofAttribute: "width"),
            let height: Double = svgElement.value(ofAttribute: "height")
        else {
            throw SVG.Parser.Error.illFormedRectangle(svgElement)
        }
        
        self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
    }
}

extension Rectangle {
    
    /// Things that can go wrong when creating a `Rectangle` from an `SVG` element.
    public enum SVGError: Swift.Error {
        case illFormed([Double])
    }
    
    // In the form: "x y width height"
    init(string: String) throws {
        try self.init(stringValues: string.components(separatedBy: " "))
    }
    
    // In the form: x,y,width,height
    init(stringValues: [String]) throws {
        try self.init(values: stringValues.compactMap { Double($0) })
    }
    
    // In the form: x,y,width,height
    init(values: [Double]) throws {
        
        guard values.count == 4 else {
            throw SVGError.illFormed(values)
        }
        
        self.init(x: values[0], y: values[1], width: values[2], height: values[3])
    }
}


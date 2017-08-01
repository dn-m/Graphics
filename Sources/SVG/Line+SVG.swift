//
//  Line+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import Geometry

extension Line.Segment: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        
        guard
            let x1: Double = svgElement.value(ofAttribute: "x1"),
            let y1: Double = svgElement.value(ofAttribute: "y1"),
            let x2: Double = svgElement.value(ofAttribute: "x2"),
            let y2: Double = svgElement.value(ofAttribute: "y2")
        else {
            throw SVG.Parser.Error.illFormedLine(svgElement)
        }
        
        self.init(start: Point(x: x1, y: y1), end: Point(x: x2, y: y2))
    }
}


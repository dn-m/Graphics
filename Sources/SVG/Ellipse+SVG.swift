//
//  Ellipse+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import Geometry

extension Ellipse: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        
        guard
            let x: Double = svgElement.value(ofAttribute: "cx"),
            let y: Double = svgElement.value(ofAttribute: "cy"),
            let radiusX: Double = svgElement.value(ofAttribute: "rx"),
            let radiusY: Double = svgElement.value(ofAttribute: "ry")
        else {
            throw SVG.Parser.Error.illFormedEllipse(svgElement)
        }
        
        self.init(
            center: Point(x: x, y: y),
            size: Size(width: 2 * radiusX, height: 2 * radiusY)
        )
    }
}


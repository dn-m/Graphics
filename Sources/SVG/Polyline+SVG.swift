//
//  Polyline+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import Geometry

extension Polyline: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        
        guard let pointsString: String = svgElement.value(ofAttribute: "points") else {
            throw SVG.Parser.Error.illFormedPolyline(svgElement)
        }
        
        let points = pointsString
            .components(separatedBy: " ").filter { $0 != "" }
            .compactMap(Point.init)
        
        self.init(points)
    }
}

#endif

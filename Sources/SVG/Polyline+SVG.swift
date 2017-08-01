//
//  Polyline+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

//import Geometry
//
//extension Polyline: SVGInitializable {
//    
//    init(svgElement: SVGElement) throws {
//        
//        guard let pointsString: String = svgElement.value(ofAttribute: "points") else {
//            throw SVG.Parser.Error.illFormedPolyline(svgElement)
//        }
//        
//        let points = pointsString
//            .components(separatedBy: " ").filter { $0 != "" }
//            .flatMap { Point(string: $0) }
//        
//        self.init(points)
//    }
//}


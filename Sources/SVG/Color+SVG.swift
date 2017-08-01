//
//  Color+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/20/17.
//
//

//import Foundation
//
//extension Color {
//    
//    enum Attribute: String {
//        case fill, stroke
//    }
//    
//    static func makeColor(svgElement: SVGElement, for attribute: Attribute) throws -> Color {
//        return try makeColor(svgElement: svgElement, for: attribute.rawValue)
//    }
//    
//    static func makeColor(svgElement: SVGElement, for attribute: String) throws -> Color {
//        
//        let colorString: String = svgElement.value(ofAttribute: attribute) ?? "#000000"
//        
//        let opacity: Double = svgElement.value(ofAttribute: "\(attribute)-opacity")
//            ?? svgElement.value(ofAttribute: "opacity")
//            ?? 1
//        
//        guard let color = Color(hex: colorString, alpha: opacity) else {
//            throw SVG.Parser.Error.illFormedStroke(svgElement)
//        }
//        
//        return color
//    }
//}


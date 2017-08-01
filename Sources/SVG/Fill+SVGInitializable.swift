//
//  Fill+SVGInitializable.swift
//  Rendering
//
//  Created by James Bean on 6/20/17.
//
//

//extension Fill: SVGInitializable {
//    
//    init(svgElement: SVGElement) throws {
//        
//        func color(_ svgElement: SVGElement) throws -> Color {
//            
//            let colorString: String = svgElement.value(ofAttribute: "fill") ?? "#000000"
//            
//            let opacity: Double = svgElement.value(ofAttribute: "fill-opacity")
//                ?? svgElement.value(ofAttribute: "opacity")
//                ?? 1
//            
//            guard let color = Color(hex: colorString, alpha: opacity) else {
//                throw SVG.Parser.Error.illFormedFill(svgElement)
//            }
//            
//            return color
//        }
//        
//        self.init(
//            color: try Color.makeColor(svgElement: svgElement, for: .fill),
//            rule: try Fill.Rule(svgElement: svgElement)
//        )
//    }
//}
//
//
//extension Fill.Rule: SVGInitializable {
//    
//    init(svgElement: SVGElement) throws {
//        
//        let ruleString: String = svgElement.value(ofAttribute: "fill-rule") ?? "nonZero"
//        
//        guard let rule = Fill.Rule(rawValue: ruleString) else {
//            throw SVG.Parser.Error.illFormedFill(svgElement)
//        }
//        
//        self = rule
//    }
//}


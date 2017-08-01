//
//  Stroke+SVGInitializable.swift
//  Rendering
//
//  Created by James Bean on 6/20/17.
//
//

//extension Stroke: SVGInitializable {
//    
//    init(svgElement: SVGElement) throws {
//        
//        let width: Double = svgElement.value(ofAttribute: "stroke-width") ?? 1
//        
//        // TODO: Cap
//        // TODO: Dashes
//        
//        self.init(
//            width: width,
//            color: try Color.makeColor(svgElement: svgElement, for: .stroke),
//            join: try Stroke.Join(svgElement: svgElement),
//            cap: .butt,
//            dashes: nil
//        )
//    }
//}
//
//extension Stroke.Join: SVGInitializable {
//    
//    init(svgElement: SVGElement) throws {
//        
//        let lineJoinString: String = svgElement.value(ofAttribute: "stroke-linejoin")
//            ?? "miter"
//        
//        switch lineJoinString {
//        case "round":
//            self = .round
//        case "bevel":
//            self = .bevel
//        case "miter":
//            let limit: Double = svgElement.value(ofAttribute: "miter-limit") ?? 10
//            self = .miter(limit: limit)
//        default:
//            throw SVG.Parser.Error.illFormedFill(svgElement)
//        }
//    }
//}


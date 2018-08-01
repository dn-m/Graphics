//
//  RenderedPath+CAShapeLayer.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import QuartzCore
import Rendering

extension CAShapeLayer {
    
    public convenience init (_ renderedPath: RenderedPath) {
        
        self.init(renderedPath.path)
        frame = CGRect(renderedPath.frame)
        let styling = renderedPath.styling
        fillColor = styling.fill.color.cgColor

        #warning("Add availability checking for fill and stroke conversions")
//        if #available(macOS 10.14, *) {
//            fillRule = styling.fill.rule.cgFillRule
//            lineCap = styling.stroke.cap.cgCap
//            lineJoin = styling.stroke.join.cgJoin
//        }

        strokeColor = styling.stroke.color.cgColor
        lineDashPattern = styling.stroke.dashes?.pattern.map { NSNumber.init(value: $0) }
        lineWidth = CGFloat(styling.stroke.width)
        
        if let dashPhase = styling.stroke.dashes?.phase {
            lineDashPhase = CGFloat(dashPhase)
        }
        
        if case .miter(let limit) = styling.stroke.join {
            miterLimit = CGFloat(limit)
        }
    }
}

#warning("Reintroduce Fill.Rule -> CAShapeLayerFillRule when available")
//internal extension Fill.Rule {
//
//    @available(macOS 10.14, *)
//    var cgFillRule: CAShapeLayerFillRule {
//        switch self {
//        case .nonZero:
//            return .nonZero
//        case .evenOdd:
//            return .evenOdd
//        }
//    }
//}
//

#warning("Reintroduce Stroke.Cap -> CAShapeLayerLineCap when available")
//internal extension Stroke.Cap {
//
//    @available(macOS 10.14, *)
//    var cgCap: CAShapeLayerLineCap {
//        switch self {
//        case .butt:
//            return .butt
//        case .round:
//            return .round
//        case .square:
//            return .square
//        }
//    }
//}
//

#warning("Reintroduce Stroke.Join -> CAShapeLayerLineJoin when available")
//internal extension Stroke.Join {
//
//    @available(macOS 10.14, *)
//    var cgJoin: CAShapeLayerLineJoin {
//        switch self {
//        case .miter:
//            return .miter
//        case .bevel:
//            return .bevel
//        case .round:
//            return .round
//        }
//    }
//}

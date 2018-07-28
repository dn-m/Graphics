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
        fillRule = styling.fill.rule.cgFillRule
        strokeColor = styling.stroke.color.cgColor
        lineCap = styling.stroke.cap.cgCap
        lineDashPattern = styling.stroke.dashes?.pattern.map { NSNumber.init(value: $0) }
        lineJoin = styling.stroke.join.cgJoin
        lineWidth = CGFloat(styling.stroke.width)
        
        if let dashPhase = styling.stroke.dashes?.phase {
            lineDashPhase = CGFloat(dashPhase)
        }
        
        if case .miter(let limit) = styling.stroke.join {
            miterLimit = CGFloat(limit)
        }
    }
}

internal extension Fill.Rule {
    
    var cgFillRule: CAShapeLayerFillRule {
        switch self {
        case .nonZero:
            return .nonZero
        case .evenOdd:
            return .evenOdd
        }
    }
}

internal extension Stroke.Cap {
    
    var cgCap: CAShapeLayerLineCap {
        switch self {
        case .butt:
            return .butt
        case .round:
            return .round
        case .square:
            return .square
        }
    }
}

internal extension Stroke.Join {
    
    var cgJoin: CAShapeLayerLineJoin {
        switch self {
        case .miter:
            return .miter
        case .bevel:
            return .bevel
        case .round:
            return .round
        }
    }
}


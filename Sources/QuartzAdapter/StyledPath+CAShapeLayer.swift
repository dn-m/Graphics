//
//  StyledPath+CAShapeLayer.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import QuartzCore
import Rendering

extension CAShapeLayer {
    
    public convenience init (_ styledPath: StyledPath) {
        
        self.init(styledPath.path)
        frame = CGRect(styledPath.frame)
        let styling = styledPath.styling
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
    
    var cgFillRule: String {
        switch self {
        case .nonZero:
            return kCAFillRuleNonZero
        case .evenOdd:
            return kCAFillRuleEvenOdd
        }
    }
}

internal extension Stroke.Cap {
    
    var cgCap: String {
        switch self {
        case .butt:
            return kCALineCapButt
        case .round:
            return kCALineCapRound
        case .square:
            return kCALineCapSquare
        }
    }
}

internal extension Stroke.Join {
    
    var cgJoin: String {
        switch self {
        case .miter:
            return kCALineJoinMiter
        case .bevel:
            return kCALineJoinBevel
        case .round:
            return kCALineJoinRound
        }
    }
}


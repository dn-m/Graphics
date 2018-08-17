//
//  StyledPath+CAShapeLayer.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Rendering

extension CAShapeLayer {
    
    public convenience init (_ styledPath: StyledPath) {
        self.init(styledPath.path)
        let styling = styledPath.styling
        self.fillColor = styling.fill.color.cgColor
        self.strokeColor = styling.stroke.color.cgColor
        self.lineDashPattern = styling.stroke.dashes?.pattern.map { NSNumber.init(value: $0) }
        self.lineWidth = CGFloat(styling.stroke.width)
        if let dashPhase = styling.stroke.dashes?.phase { self.lineDashPhase = CGFloat(dashPhase) }
        if case .miter(let limit) = styling.stroke.join { self.miterLimit = CGFloat(limit) }
        self.adaptProperties(from: styledPath)
        self.frame = CGRect(styledPath.frame)
    }

    /// Adapts the fill rule, line cap, and line join from the given `styledPath` for the Quartz
    /// version supplied with the listed operating systems.
    func adaptProperties(from styledPath: StyledPath) {

        if #available(macOS 10.14, iOS 12.0, tvOS 12.0, *) {
            var cgFillRule: CAShapeLayerFillRule {
                switch styledPath.styling.fill.rule {
                case .nonZero:
                    return .nonZero
                case .evenOdd:
                    return .evenOdd
                }
            }

            var cgCap: CAShapeLayerLineCap {
                switch styledPath.styling.stroke.cap {
                case .butt:
                    return .butt
                case .round:
                    return .round
                case .square:
                    return .square
                }
            }

            var cgJoin: CAShapeLayerLineJoin {
                switch styledPath.styling.stroke.join {
                case .miter:
                    return .miter
                case .bevel:
                    return .bevel
                case .round:
                    return .round
                }
            }

            self.fillRule = cgFillRule
            self.lineCap = cgCap
            self.lineJoin = cgJoin
        } else {
            print("Fill.Rule is not avilable on your platform!")
        }
    }
}

#endif

//
//  StyledPath.Composite+CALayer.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import QuartzCore
import Rendering

extension CALayer {

    public convenience init(_ composite: Composite) {

        func traverse(_ composite: Composite, building container: CALayer) {
            switch composite {

            // FIXME: Encapsulate in Item
            case .leaf(let item):
                switch item {
                case .path(let styledPath):
                    let layer = CAShapeLayer(styledPath)
                    container.addSublayer(layer)
                case .text:
                    fatalError()
                }

            case .branch(let group, let trees):
                let layer = CALayer()
                layer.frame = CGRect(group.frame)
                trees.forEach { traverse($0, building: layer) }
                container.addSublayer(layer)
            }
        }

        self.init()
        self.frame = CGRect(composite.frame)
        traverse(composite.resizedToFitContents, building: self)
    }
}

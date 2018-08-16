//
//  RenderedPath.Composite+CALayer.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Rendering

extension CALayer {

    public convenience init(_ composite: RenderedPath.Composite) {

        func traverse(_ composite: RenderedPath.Composite, building container: CALayer) {
            switch composite {

            // FIXME: Encapsulate in Item
            case .leaf(let item):
                switch item {
                case .path(let renderedPath):
                    let layer = CAShapeLayer(renderedPath)
                    container.addSublayer(layer)
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

#endif

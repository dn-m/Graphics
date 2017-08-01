//
//  TestFrame.swift
//  Rendering
//
//  Created by James Bean on 6/2/17.
//
//

import Rendering
import QuartzCore

extension CALayer {

    public func showTestBorder() {
        borderWidth = 0.5
        borderColor = Color(red: 255, green: 0, blue: 0, alpha: 0.5).cgColor
        backgroundColor = Color(white: 0, alpha: 0.025).cgColor
    }

    func showAllTestBorders() {

        func traverse(layer: CALayer) {
            layer.showTestBorder()
            if let children = layer.sublayers {
                children.forEach(traverse)
            }
        }
        
        traverse(layer: self)
    }
}

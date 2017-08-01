//
//  SVGTests.swift
//  GraphicsTools
//
//  Created by James Bean on 6/16/17.
//
//

import GraphicsTools
import GraphicsTestTools
import XCTest

class SVGTests: GraphicsTestCase {
    
    func testParseSVG() {
        
        let testFiles = [
            "line",
            "polyline",
            "polygon",
            "square",
            "rect",
            "circle",
            "ellipse",
            "curve1",
            "curve2",
            "multiple_objects",
            "multiple_groups",
            "polybezier",
            "bbox"
        ]
        
        for name in testFiles {
            do {
                let svg = try SVG(name: name)
                let path = Composite(svg)
                print(path)
                let layer = CALayer(path)
                render(layer, name: name)
            } catch {
                print(error)
            }
        }
    }

    func testScaleSVG() {

        do {
            let svg = try SVG(name: "bbox")
            let pathByHeight = Composite(svg, height: 1000)
            let pathByWidth = Composite(svg, width: 20)
            let pathByHeightLayer = CALayer(pathByHeight)
            let pathByWidthLayer = CALayer(pathByWidth)
            render(pathByHeightLayer, name: "bbox_scale_to_height")
            render(pathByWidthLayer, name: "bbox_scale_to_width")
        } catch {
            print(error)
        }
    }
}

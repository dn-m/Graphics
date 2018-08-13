//
//  Styling+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import Rendering

extension Styling: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        self.init(
            fill: try Fill(svgElement: svgElement),
            stroke: try Stroke(svgElement: svgElement)
        )
    }
}

#endif

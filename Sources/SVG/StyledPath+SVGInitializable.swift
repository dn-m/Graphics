//
//  RenderedPath+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import DataStructures
import Path
import Rendering

extension RenderedPath {
    
    init(svgElement: SVGElement) throws {
        self.init(
            path: try Path(svgElement: svgElement),
            styling: try Styling(svgElement: svgElement)
        )
    }
}

#endif

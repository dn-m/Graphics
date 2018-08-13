//
//  SVGInitializable.swift
//  Rendering
//
//  Created by James Bean on 6/17/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import DataStructures
import Geometry
import Path

/// Interface for types which can be initialized with an `SVG` element
protocol SVGInitializable {
    init(svgElement: SVGElement) throws
}

#endif

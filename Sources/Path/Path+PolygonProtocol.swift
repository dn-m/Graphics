//
//  Path+PolygonProtocol.swift
//  Path
//
//  Created by James Bean on 6/17/17.
//
//

import Geometry

extension Path {
    
    /// Creates a `Path` with the given `polygon`.
    public init <P: PolygonProtocol> (_ polygon: P) {
        self.init(polygon.edges.map(BezierCurve.init))
    }
}

extension Path {
    
    public init(vertices: [Point]) {
        switch vertices.count {
        case 0:
            self.init([])
        case 1:
            self.init([BezierCurve(start: vertices[0], end: vertices[0])])
        case 2:
            self.init([BezierCurve(start: vertices[0], end: vertices[1])])
        default:
            let polygon = Polygon(vertices: vertices)
            self.init(polygon)
        }
    }
}

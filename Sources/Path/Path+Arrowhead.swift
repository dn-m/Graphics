//
//  Path+Arrowhead.swift
//  Path
//
//  Created by James Bean on 6/11/16.
//
//

import Geometry

extension Path {
    
    // MARK: - Arrowhead

    public static func arrowhead(
        tip: Point = Point(),
        height: Double = 100,
        width: Double = 25,
        barbProportion: Double = 0.25,
        rotation: Angle = .zero
    ) -> Path
    {
        
        let builder = Path.builder
            .move(to: Point(x: 0.5 * width, y: 0))
            .addLine(to: Point(x: width, y: height))
            .addLine(to: Point(x: 0.5 * width, y: height - (barbProportion * height)))
            .addLine(to: Point(x: 0, y: height))
            .close()
        
        let path = builder.build()
        
        guard rotation == .zero else {
            return path.rotated(by: rotation)
        }

        return path
    }
}

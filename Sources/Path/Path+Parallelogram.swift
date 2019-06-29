////
////  Path+Parallelogram.swift
////  Path
////
////  Created by James Bean on 6/11/16.
////
////
//
//import Geometry
//
//extension Path {
//    
//    // MARK: - Parallelogram
//    
//    /**
//     - returns: `Path` of a slanted bar.
//     
//     - note: The sides are always vertical, independant of the slope.
//     
//     - note: Useful for accidental components and system dividers.
//     */
//    public static func parallelogram(
//        center: Point,
//        height: Double,
//        width: Double,
//        slope: Double
//    ) -> Path
//    {
//        
//        func y(at x: Double) -> Double {
//            return center.y + slope * (x - 0.5 * width)
//        }
//        
//        let left: Double = center.x - 0.5 * width
//        let right: Double = left + width
//        
//        let topLeftY: Double = y(at: left) + 0.5 * height
//        let topRightY: Double = y(at: right) + 0.5 * height
//        let bottomRightY: Double = y(at: right) - 0.5 * height
//        let bottomLeftY: Double = y(at: left) - 0.5 * height
//        
//        let builder = Path.builder
//            .move(to: Point(x: left, y: topLeftY))
//            .addLine(to: Point(x: right, y: topRightY))
//            .addLine(to: Point(x: right, y: bottomRightY))
//            .addLine(to: Point(x: left, y: bottomLeftY))
//            .close()
//        
//        return builder.build()
//    }
//}

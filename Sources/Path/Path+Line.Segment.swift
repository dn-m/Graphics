////
////  Path+Line.Segment.swift
////  Path
////
////  Created by James Bean on 6/17/17.
////
////
//
//import Geometry
//
//extension Line.Segment: PathRepresentable {
//    
//    public var path: Path {
//        return Path([BezierCurve(self)])
//    }
//}
//
//extension Path {
//    
//    public static func line(from start: Point, to end: Point) -> Path {
//        return Line.Segment(start: start, end: end).path
//    }
//}

//
//  QuadraticBezierCurveTests.swift
//  PathTools
//
//  Created by James Bean on 6/8/17.
//
//

import XCTest
import GeometryTools
import PathTools

class QuadraticBezierCurveTests: XCTestCase {
    
    // MARK: - Quadratic
    
//    func testTAtMinX() {
//        
//        let slopeDown = BezierCurve(
//            start: Point(x: 0, y: 1),
//            control: Point(x: 0, y: 0),
//            end: Point(x: 1, y: 0)
//        )
//        
//        XCTAssertEqual(slopeDown.t(at: (.min, .horizontal)), 0)
//    }
//    
//    func testTAtMaxX() {
//        
//        let slopeDown = BezierCurve(
//            start: Point(x: 0, y: 1),
//            control: Point(x: 0, y: 0),
//            end: Point(x: 1, y: 0)
//        )
//        
//        XCTAssertEqual(slopeDown.t(at: (.max, .horizontal)), 1)
//    }
//    
//    func testTAtMinY() {
//        
//        let slopeDown = BezierCurve(
//            start: Point(x: 0, y: 1),
//            control: Point(x: 0, y: 0),
//            end: Point(x: 1, y: 0)
//        )
//        
//        XCTAssertEqual(slopeDown.t(at: (.min, .vertical)), 1)
//    }
//    
//    func testTAtMaxY() {
//        
//        let slopeDown = BezierCurve(
//            start: Point(x: 0, y: 1),
//            control: Point(x: 0, y: 0),
//            end: Point(x: 1, y: 0)
//        )
//        
//        XCTAssertEqual(slopeDown.t(at: (.max, .vertical)), 0)
//    }
    
    func testYsAtX() {

        let slopeDown = BezierCurve(
            start: Point(x: 0, y: 1),
            control: Point(x: 0, y: 0),
            end: Point(x: 1, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.01).forEach { t in
            
            let point = slopeDown[t]
            let ys = slopeDown.ys(x: point.x)
            
            XCTAssertEqual(ys.count, 1)
            XCTAssertEqualWithAccuracy(ys.first!, point.y, accuracy: 0.0000001)
        }
    }
    
    func testXsAtY() {
        
        let slopeDown = BezierCurve(
            start: Point(x: 0, y: 1),
            control: Point(x: 0, y: 0),
            end: Point(x: 1, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.01).forEach { t in
            
            let point = slopeDown[t]
            let xs = slopeDown.xs(y: point.y)
            
            XCTAssertEqual(xs.count, 1)
            XCTAssertEqualWithAccuracy(xs.first!, point.x, accuracy: 0.0000001)
        }
    }
}

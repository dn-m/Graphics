//
//  LinearBezierCurveTests.swift
//  PathTools
//
//  Created by James Bean on 6/12/17.
//
//

import XCTest
import GeometryTools
import PathTools

class LinearBezierCurveTests: XCTestCase {
    
    func testInit() {
        _ = BezierCurve(start: Point(), end: Point(x: 1, y: 1))
    }
    
    func testPointAtT() {
        
        let linear = BezierCurve(start: Point(), end: Point(x: 1, y: 1))
        let points = stride(from: 0, through: 1, by: 0.25).map { t in linear[t] }
        
        let expected = [
            Point(x: 0, y: 0),
            Point(x: 0.25, y: 0.25),
            Point(x: 0.5, y: 0.5),
            Point(x: 0.75, y: 0.75),
            Point(x: 1, y: 1)
        ]
        
        XCTAssertEqual(points, expected)
    }
    
    func testXsAtY() {

        let linear = BezierCurve(start: Point(), end: Point(x: 1, y: 1))
        let xs = stride(from: 0, through: 1, by: 0.25).map { t in linear[t].x }
        let ys = xs.map { x in linear.ys(x: x) }
        let expected = xs.map { x in Set([x]) }
        
        XCTAssertEqual(ys, expected)
    }
    
    func testYsAtX() {
        
        let linear = BezierCurve(start: Point(), end: Point(x: 1, y: 1))
        let ys = stride(from: 0, through: 1, by: 0.25).map { t in linear[t].y }
        let xs = ys.map { y in linear.xs(y: y) }
        let expected = ys.map { y in Set([y]) }
        
        XCTAssertEqual(xs, expected)
    }
}

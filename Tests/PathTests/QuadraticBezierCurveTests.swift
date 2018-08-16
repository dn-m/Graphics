//
//  QuadraticBezierCurveTests.swift
//  Path
//
//  Created by James Bean on 6/8/17.
//
//

import XCTest
import Geometry
import Path

class QuadraticBezierCurveTests: XCTestCase {
    
    // MARK: - Quadratic
    
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
            XCTAssertEqual(ys.first!, point.y, accuracy: 1e-6)
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
            XCTAssertEqual(xs.first!, point.x, accuracy: 1e-6)
        }
    }
}

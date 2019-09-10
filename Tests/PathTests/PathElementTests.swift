//
//  PathElementTests.swift
//  Path
//
//  Created by James Bean on 1/18/17.
//
//

#if os(iOS)

import XCTest
import Geometry
import Path
import QuartzAdapter

class PathElementTests: XCTestCase {

    func testCustomStringConvertible() {
        let element = PathElement.curve(
            Point(x: 100, y: 100),
            Point(x: 150, y: 150),
            Point(x: 400, y: 0)
        )
        print(element)
    }
    
    func testCurve() {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.addCurve(
            to: CGPoint(x: 1, y: 1),
            controlPoint1: CGPoint(x: 0.5, y: 0),
            controlPoint2: CGPoint(x: 1, y: 0.5)
        )
        let cgPath = bezierPath.cgPath
        let result = Path(cgPath)
        let expected = Path.builder
            .move(to: Point())
            .addCurve(
                to: Point(x: 1, y: 1),
                control1: Point(x: 0.5, y: 0),
                control2: Point(x: 1, y: 0.5)
            )
            .build()
        XCTAssertEqual(result, expected)
    }
    
    func testQuadCurve() {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.addQuadCurve(to: CGPoint(x: 1, y: 1), controlPoint: CGPoint(x: 1, y: 0))
        let cgPath = bezierPath.cgPath
        let result = Path(cgPath)
        let expected = Path.builder
            .move(to: Point())
            .addQuadCurve(to: Point(x: 1, y: 1), control: Point(x: 1, y: 0))
            .build()

        XCTAssertEqual(result, expected)
    }
}

#endif

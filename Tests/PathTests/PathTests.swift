//
//  PathTests.swift
//  Path
//
//  Created by James Bean on 6/10/16.
//
//

import XCTest
import Algebra
import Geometry
@testable import Path

class PathTests: XCTestCase {

    func testMoveTo() {
        let path = Path.builder.move(to: Point()).build()
        XCTAssertEqual(path.count, 0)
    }
    
    func testMoveToLineTo() {
        let path = Path.builder
            .move(to: Point())
            .addLine(to: Point())
            .build()
        XCTAssertEqual(path.count, 1)
    }
    
    func testInitWithCGRect() {
        let rect = Rectangle(origin: Point(), size: Size())
        let _ = Path.rectangle(rect)
    }
    
    func testCustomStringConvertible() {
        
        let builder = Path.builder
            .move(to: Point(x: 100, y: 100))
            .addLine(to: Point(x: 200, y: 200))
            .addQuadCurve(to: Point(x: 300, y: 0), control: Point(x: 200, y: 100))
            .addCurve(
                to: Point(x: 200, y: 150),
                control1: Point(x: 400, y: 200),
                control2: Point(x: 100, y: 200)
            )
        let path = builder.build()
        print(path)
    }
    
    func testAddCurve() {
        
        let curve = BezierCurve(
            start: Point(),
            control1: Point(x: 1, y: 0),
            control2: Point(x: 1, y: 0),
            end: Point(x: 1, y: 1)
        )
        
        let path = Path.builder.addCurve(curve).build()
        
        let expected = Path.builder
            .move(to: Point())
            .addCurve(
                to: Point(x: 1, y: 1),
                control1: Point(x: 1, y: 0),
                control2: Point(x: 1, y: 0)
            )
            .build()
        
        XCTAssertEqual(path, expected)
    }

    func testSimplified() {

        let path = Path.builder
            .addCurve(
                BezierCurve(
                    start: Point(x: -1, y: 0),
                    control1: Point(x: 0, y: 1),
                    control2: Point(x: 0, y: -1),
                    end: Point(x: 1, y: 0)
                )
            )
            .addLine(to: Point(x: 0, y: 1))
            .addQuadCurve(to: Point(x: -1, y: 0), control: Point(x: -1, y: 0))
            .build()

        let simplified = path.simplified(segmentCount: 50)
        #warning("TODO: Add assertion in PathTests.testSimplified()")
        // TODO: Add assertion
    }
}

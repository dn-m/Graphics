//
//  PathTests.swift
//  PathTools
//
//  Created by James Bean on 6/10/16.
//
//

import XCTest
import Algebra
import Collections
import ArithmeticTools
import GeometryTools
@testable import PathTools

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
        
        // TODO: Add assertion
    }
    
    // MARK: - Factory Methods
    
    func testSquare() {
        let square = Path.square(center: Point(x: 25, y: 75), width: 50)
        let expectedCurves = [
            BezierCurve(start: Point(x: 0, y: 100), end: Point(x: 50, y: 100)),
            BezierCurve(start: Point(x: 50, y: 100), end: Point(x: 50, y: 50)),
            BezierCurve(start: Point(x: 50, y: 50), end: Point(x: 0, y: 50)),
            BezierCurve(start: Point(x: 0, y: 50), end: Point(x: 0, y: 100))
        ]
        XCTAssertEqual(square, Path(expectedCurves))
        XCTAssertEqual(square, Path(square.cgPath))
    }
    
    func testEllipse() {
        let rect = Rectangle(x: 0, y: 0, width: 200, height: 50)
        let ellipse = Path.ellipse(in: rect)
    }
    
    func testMultipleSubpaths() {
        
        let a = Path.square(center: Point(), width: 100)
        let b = Path.rectangle(origin: Point(x: 1000, y: 1000), size: Size(width: 2, height: 1))
        let sum = a + b
        
        let withBuilder = Path.builder
            
            // a
            .move(to: Point(x: -50, y: 50))
            .addLine(to: Point(x: 50, y: 50))
            .addLine(to: Point(x: 50, y: -50))
            .addLine(to: Point(x: -50, y: -50))
            .close()
            
            // b
            .move(to: Point(x: 1000, y: 1001))
            .addLine(to: Point(x: 1000, y: 1000))
            .addLine(to: Point(x: 1002, y: 1000))
            .addLine(to: Point(x: 1002, y: 1001))
            .close()
            
            .build()
        
        XCTAssertEqual(sum.curves.count, withBuilder.curves.count)
        XCTAssertEqual(sum, withBuilder)
        XCTAssertEqual(Path(withBuilder.cgPath).curves.count, withBuilder.curves.count)
        XCTAssertEqual(Path(withBuilder.cgPath), withBuilder)
    }
    
    func testManySubpathsToCGPath() {
        
        let path: Path = [(0,0),(100,100),(200,200)]
            .map(Point.init)
            .map { point in Path.square(center: point, width: 20) }
            .sum
        
        XCTAssertEqual(path, Path(path.cgPath))
    }
    
    func testParallelograms() {
        let path = Path.parallelogram(center: Point(), height: 30, width: 100, slope: 0.5)
        path.curves.forEach { print($0) }
        XCTAssertEqual(path, Path(path.cgPath))
    }
}

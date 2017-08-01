//
//  PathElementTests.swift
//  PathTools
//
//  Created by James Bean on 1/18/17.
//
//

import XCTest
import GeometryTools
import PathTools

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
        
        #if os(iOS)
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
            
        #endif
    }
    
    func testQuadCurve() {
        
        #if os(iOS)
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
            
        #endif
    }
}

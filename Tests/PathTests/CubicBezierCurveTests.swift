//
//  CubicBezierCurveTests.swift
//  Path
//
//  Created by James Bean on 6/9/17.
//
//

import XCTest
import Geometry
import Rendering
import GraphicsTesting
@testable import Path

class CubicBezierCurveTests: XCTestCase {

    override func setUp() {
        createArtifactsDirectory(for: "\(type(of: self))")
    }

    override func tearDown() {
        openArtifactsDirectory()
    }
    
    func testUpAndDown() {

        let upAndDown = BezierCurve(
            start: Point(x: -1, y: 0),
            control1: Point(x: 0, y: 1),
            control2: Point(x: 0, y: -1),
            end: Point(x: 1, y: 0)
        )
        
        stride(from: Double(0), through: 1.0, by: 0.1).forEach { t in
            print("up and down at: \(t): \(upAndDown[t])")
        }
    }
    
    func testSlopeDown() {
        
        let slopeDown = BezierCurve(
            start: Point(x: 0, y: 1),
            control1: Point(x: 0, y: 0),
            control2: Point(x: 0, y: 0),
            end: Point(x: 1, y: 0)
        )
        
        XCTAssertEqual(slopeDown[0.5], Point(x: 0.125, y: 0.125))
    }
    
    func testSlopeUp() {
        
        let slopeDown = BezierCurve(
            start: Point(x: 0, y: 0),
            control1: Point(x: 1, y: 0),
            control2: Point(x: 1, y: 0),
            end: Point(x: 1, y: 1)
        )
        
        XCTAssertEqual(slopeDown[0.5], Point(x: 0.875, y: 0.125))
    }
    
    func testYsAtX() {
        
        let upAndDown = BezierCurve(
            start: Point(x: -1, y: 0),
            control1: Point(x: 0, y: 1),
            control2: Point(x: 0, y: -1),
            end: Point(x: 1, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.01).forEach { t in
            let point = upAndDown[t]
            let ys = upAndDown.ys(x: point.x)
            XCTAssert(ys.contains(point.y, accuracy: 0.0000001))
        }
    }
    func testXsAtY() {
        
        let upAndDown = BezierCurve(
            start: Point(x: -1, y: 0),
            control1: Point(x: 0, y: 1),
            control2: Point(x: 0, y: -1),
            end: Point(x: 1, y: 0)
        )
        
        stride(from: Double(0), to: 1, by: 0.01).forEach { t in
            let point = upAndDown[t]
            let xs = upAndDown.xs(y: point.y)
            XCTAssert(xs.contains(point.x, accuracy: 0.0000001))
        }
    }
    
    func testLength() {
        
        let upAndDown = BezierCurve(
            start: Point(x: -1, y: 0),
            control1: Point(x: 0, y: 1),
            control2: Point(x: 0, y: -1),
            end: Point(x: 1, y: 0)
        )
        
        _ = upAndDown.length
    }
    
    func testSplit() {
        
        let upAndDown = BezierCurve(
            start: Point(x: -1, y: 0),
            control1: Point(x: 0, y: 1),
            control2: Point(x: 0, y: -1),
            end: Point(x: 1, y: 0)
        )
        
        let split = upAndDown.split(t: 0.5)
        
        let expectedLeft = BezierCurve(
            [(-1.0,0.0), (-0.5,0.5), (-0.25,0.25), (0.0,0.0)].map(Point.init)
        )
        
        let expectedRight = BezierCurve(
            [(1.0,0.0), (0.5,-0.5), (0.25,-0.25), (0.0,0.0)].map(Point.init)
        )
        
        XCTAssertEqual(split.0, expectedLeft)
        XCTAssertEqual(split.1, expectedRight)
    }
    
    func testSimplify() {
        
        let upAndDown = BezierCurve(
            start: Point(x: -1, y: 0),
            control1: Point(x: 0, y: 1),
            control2: Point(x: 0, y: -1),
            end: Point(x: 1, y: 0)
        )
        
        let simple = upAndDown.simplified(segmentCount: 100)
        print(simple)
    }

    func testSplitRender() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 0),
            control1: Point(x: 0, y: 100),
            control2: Point(x: 100, y: 0),
            end: Point(x: 100, y: 100)
        )

        let (a,b) = curve.split(t: 0.75)

        let pathA = Path(a)
        let styledPathA = StyledPath(
            frame: frame,
            path: pathA,
            styling: Styling(stroke: Stroke(color: .red))
        )

        let pathB = Path(b)
        let styledPathB = StyledPath(
            frame: frame,
            path: pathB,
            styling: Styling(stroke: Stroke(color: .green))
        )
        let composite: StyledPath.Composite = .branch(group, [
            .leaf(.path(styledPathA)),
            .leaf(.path(styledPathB))
        ])
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }

    func testBoundingBoxRender() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 24, y: 82),
            control1: Point(x: 40, y: 90),
            control2: Point(x: 90, y: 9),
            end: Point(x: 100, y: 100)
        )
        let curvePath = Path(curve)
        let styledCurve = StyledPath(
            frame: frame,
            path: curvePath,
            styling: Styling(stroke: Stroke(color: .black))
        )
        let box = curve.axisAlignedBoundingBox
        let boxPath = Path.rectangle(box)
        let styledBox = StyledPath(
            frame: frame,
            path: boxPath,
            styling: Styling(stroke: Stroke(color: .red))
        )

        let composite: StyledPath.Composite = .branch(group, [
            .leaf(.path(styledBox)),
            .leaf(.path(styledCurve))
        ])
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }
}

/// - TODO: Move to `dn-m/ArithmeticTools`.
extension Sequence where Iterator.Element == Double {
    
    func contains(_ value: Double, accuracy: Double) -> Bool {
        
        for el in self {
            if abs(value - el) < accuracy {
                return true
            }
        }
        return false
    }
}

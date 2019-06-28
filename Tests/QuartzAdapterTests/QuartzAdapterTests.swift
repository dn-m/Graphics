#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import XCTest
import QuartzCore
import Geometry
import Path
import Rendering
import QuartzAdapter

class PathTests: XCTest {

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

        XCTAssertEqual(sum.base.count, withBuilder.base.count)
        XCTAssertEqual(sum, withBuilder)
        XCTAssertEqual(Path(withBuilder.cgPath).base.count, withBuilder.base.count)
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
        path.base.forEach { print($0) }
        XCTAssertEqual(path, Path(path.cgPath))
    }
}

#endif

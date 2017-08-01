//
//  PointTests.swift
//  Graphics
//
//  Created by James Bean on 6/9/17.
//
//

import XCTest
import Graphics

class PointTests: XCTestCase {

    func testDistanceTo() {
        let a = Point(x: 400, y: 600)
        let b = Point(x: 13, y: 31)
        XCTAssertEqual(a.distance(to: b), sqrt(pow(387,2) + pow(569,2)))
    }

    func testValueForAxis() {
        let point = Point(x: 25, y: 75)
        XCTAssertEqual(point[.horizontal], 25)
        XCTAssertEqual(point[.vertical], 75)
    }

    func testPointAddition() {
        let a = Point(x: 100, y: 10)
        let b = Point(x: 25, y: 30)
        XCTAssertEqual(a + b, Point(x: 125, y: 40))
    }

    func testPointSubtraction() {
        let a = Point(x: 100, y: 10)
        let b = Point(x: 25, y: 30)
        XCTAssertEqual(a - b, Point(x: 75, y: -20))
    }

    func testPointMultiply() {
        let point = Point(x: 200, y: 3)
        XCTAssertEqual(point * 3, Point(x: 600, y: 9))
        XCTAssertEqual(3 * point, Point(x: 600, y: 9))
    }

    func testPointDivision() {
        let point = Point(x: 200, y: 3)
        XCTAssertEqual(point / 2, Point(x: 100, y: 1.5))
    }

    func testScaledNoChange() {
        let point = Point(x: 3, y: 7)
        XCTAssertEqual(point.scaled(by: 1), point)
    }

    func testScaledDoubleFromOrigin() {
        let point = Point(x: 20, y: 40)
        let expected = Point(x: 40, y: 80)
        XCTAssertEqual(point.scaled(by: 2), expected)
    }

    func testScaledTripleFromReferencePoint() {
        let point = Point(x: 100, y: 100)
        let reference = Point(x: 50, y: 50)
        let expected = Point(x: 200, y: 200)
        XCTAssertEqual(point.scaled(by: 3, from: reference), expected)
    }

    func testRotateNoChange() {
        let point = Point(x: 1, y: 1)
        let angle = Angle.zero
        let rotated = point.rotated(by: angle)
        XCTAssertEqualWithAccuracy(rotated.x, point.x, accuracy: 0.0000001)
        XCTAssertEqualWithAccuracy(rotated.y, point.y, accuracy: 0.0000001)
    }

    func testRotated90DegreesAroundOrigin() {
        let point = Point(x: 1, y: 1)
        let angle = Angle(degrees: 90)
        let rotated = point.rotated(by: angle)
        let expected = Point(x: -1, y: 1)
        XCTAssertEqualWithAccuracy(rotated.x, expected.x, accuracy: 0.0000001)
        XCTAssertEqualWithAccuracy(rotated.y, expected.y, accuracy: 0.0000001)
    }

    func testRotated90DegressAroundPoint() {
        let point = Point(x: 10, y: 10)
        let reference = Point(x: 5, y: 5)
        let angle = Angle(degrees: 90)
        let rotated = point.rotated(by: angle, around: reference)
        let expected = Point(x: 0, y: 10)
        XCTAssertEqualWithAccuracy(rotated.x, expected.x, accuracy: 0.0000001)
        XCTAssertEqualWithAccuracy(rotated.y, expected.y, accuracy: 0.0000001)
    }

    func testReflectedOverXAxis() {
        let point = Point(x: -10, y: 10)
        let line = Line.horizontal(0)
        let result = point.reflected(over: line)
        let expected = Point(x: -10, y: -10)
        XCTAssertEqual(result, expected)
    }

    func testReflectedOverYAxis() {
        let point = Point(x: -10, y: 10)
        let line = Line.vertical(0)
        let result = point.reflected(over: line)
        let expected = Point(x: 10, y: 10)
        XCTAssertEqual(result, expected)
    }

    func testReflectedOverLine() {
        let point = Point(x: -1, y: 1)
        let line = Line(slope: 1, intercept: 0)
        let result = point.reflected(over: line)
        let expected = Point(x: 1, y: -1)
        XCTAssertEqual(result, expected)
    }
}

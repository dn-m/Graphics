//
//  LineTests.swift
//  Path
//
//  Created by James Bean on 6/6/17.
//
//

import XCTest
import Geometry

class LineTests: XCTestCase {

    func testLineLengthHorizontal() {
        let line = Line.Segment(start: Point(), end: Point(x: 1, y: 0))
        XCTAssertEqual(line.length, 1)
    }

    func testLineLengthVertical() {
        let line = Line.Segment(start: Point(), end: Point(x: 0, y: 1))
        XCTAssertEqual(line.length, 1)
    }

    func testLineLengthPositiveDiagonal() {
        let line = Line.Segment(start: Point(), end: Point(x: 1, y: -1))
        XCTAssertEqual(line.length, sqrt(2))
    }

    func testHorizontalLinePerpendicular() {
        let line = Line.horizontal(5)
        let point = Point(x: 100, y: 100)
        let result = line.perpendicular(containing: point)
        let expected = Line.vertical(100)
        XCTAssertEqual(result, expected)
    }

    func testVerticalLinePerpendicular() {
        let line = Line.vertical(5)
        let point = Point(x: 100, y: 100)
        let result = line.perpendicular(containing: point)
        let expected = Line.horizontal(100)
        XCTAssertEqual(result, expected)
    }

    func testSlantedLinePerpendicular() {
        let line = Line(slope: 2, intercept: 1)
        let point = Point(x: 0, y: 1)
        let result = line.perpendicular(containing: point)
        let expected = Line(slope: -1/2, intercept: 1)
        XCTAssertEqual(result, expected)
    }

    func testRayPointAtDistance() {
        let segment = Line.Segment(start: Point(), end: Point(x: 1, y: 1))
        let ray = Line.Ray(segment)
        let distance: Double = hypot(1,1)
        let expected = Point(x: 1, y: 1)
        XCTAssertEqual(ray.point(at: distance), expected)
    }

    func testInitWithSegment() {
        let segment = Line.Segment(start: Point(x: 1, y: 1), end: Point(x: 5, y: 5))
        let line = Line(segment)
        XCTAssertEqual(line, .slanted(slope: 1, intercept: 0))
    }

    func testRayInitWithSegmentVerticalUp() {
        let segment = Line.Segment(start: Point(), end: Point(x: 0, y: 10))
        let ray = Line.Ray(segment)
        let expected = Line.Ray.up(Point())
        XCTAssertEqual(ray, expected)
    }

    func testRayInitWithSegmentVerticalDown() {
        let segment = Line.Segment(start: Point(x: 0, y: 10), end: Point())
        let ray = Line.Ray(segment)
        let expected = Line.Ray.down(Point(x: 0, y: 10))
        XCTAssertEqual(ray, expected)
    }

    func testRayInitWithSegmentHorizontalLeft() {
        let segment = Line.Segment(start: Point(x: 10, y: 0), end: Point())
        let ray = Line.Ray(segment)
        let expected = Line.Ray.left(Point(x: 10, y: 0))
        XCTAssertEqual(ray, expected)
    }

    func testRayInitWithSegmentHorizontalRight() {
        let segment = Line.Segment(start: Point(), end: Point(x: 10, y: 0))
        let ray = Line.Ray(segment)
        let expected = Line.Ray.right(Point())
        XCTAssertEqual(ray, expected)
    }

    func testRayPointAtDistanceVertical() {
        let ray = Line.Ray.up(Point())
        let expected = Point(x: 0, y: 10)
        XCTAssertEqual(ray.point(at: 10), expected)
    }

    func testRayPointAtDistanceHorizontal() {
        let ray = Line.Ray.left(Point())
        let expected = Point(x: -10, y: 0)
        XCTAssertEqual(ray.point(at: 10), expected)
    }
}

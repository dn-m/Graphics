//
//  RectangleTests.swift
//  Geometry
//
//  Created by Brian Heim on 7/9/17.
//
//


import XCTest
import Structure
import Math
import Geometry

class RectangleTests: XCTestCase {

    // MARK - normalized

    func testNormalizedIdentity() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: 1, height: 2))
        let expected = r
        XCTAssertEqual(r.normalized, expected)
    }

    func testNormalizedFlipX() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: -1, height: 2))
        let expected = Rectangle(origin: Point(x: -1, y: 5), size: Size(width: 1, height: 2))
        XCTAssertEqual(r.normalized, expected)
    }

    func testNormalizedFlipY() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: 1, height: -2))
        let expected = Rectangle(origin: Point(x: 0, y: 3), size: Size(width: 1, height: 2))
        XCTAssertEqual(r.normalized, expected)
    }

    func testNormalizedFlipXAndY() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: -1, height: -2))
        let expected = Rectangle(origin: Point(x: -1, y: 3), size: Size(width: 1, height: 2))
        XCTAssertEqual(r.normalized, expected)
    }

    // MARK - scaled(by:, around:)

    func testScaled() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 6, height: 9))
        XCTAssertEqual(r.scaled(by: 3, around: .origin), expected)
    }

    func testScaledAroundCenter() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: -1, y: 2), size: Size(width: 6, height: 9))
        XCTAssertEqual(r.scaled(by: 3, around: .center), expected)
    }

    // MARK - scaledBy(width:, height:, around:)

    func testScaledBy() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 6, height: 12))
        XCTAssertEqual(r.scaledBy(width: 3, height: 4, around: .origin), expected)
    }

    func testScaledByWidthOnly() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 6, height: 3))
        XCTAssertEqual(r.scaledBy(width: 3, around: .origin), expected)
    }

    func testScaledByHeightOnly() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 9))
        XCTAssertEqual(r.scaledBy(height: 3, around: .origin), expected)
    }

    func testScaledByAroundCenter() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: -1, y: 0.5), size: Size(width: 6, height: 12))
        XCTAssertEqual(r.scaledBy(width: 3, height: 4, around: .center), expected)
    }

    func testScaledByWidthOnlyAroundCenter() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: -1, y: 5), size: Size(width: 6, height: 3))
        XCTAssertEqual(r.scaledBy(width: 3, around: .center), expected)
    }

    func testScaledByHeightOnlyAroundCenter() {
        let r = Rectangle(origin: Point(x: 1, y: 5), size: Size(width: 2, height: 3))
        let expected = Rectangle(origin: Point(x: 1, y: 2), size: Size(width: 2, height: 9))
        XCTAssertEqual(r.scaledBy(height: 3, around: .center), expected)
    }

    func testRectangleSum() {
        let a = Rectangle(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
        let b = Rectangle(origin: Point(x: -5, y: 5), size: Size(width: 10, height: 10))
        let expected = Rectangle(minX: -5, minY: 0, maxX: 10, maxY: 15)
        XCTAssertEqual(a + b, expected)
    }

    func testRectangleNonEmptySum() {
        let a = Rectangle(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
        let b = Rectangle(origin: Point(x: -5, y: 5), size: Size(width: 10, height: 10))
        let c = Rectangle(origin: Point(x: 2, y: 2), size: Size(width: 20, height: 1))
        let rects = [a,b,c]
        let expected = Rectangle(minX: -5, minY: 0, maxX: 22, maxY: 15)
        XCTAssertEqual(rects.nonEmptySum, expected)
    }
}

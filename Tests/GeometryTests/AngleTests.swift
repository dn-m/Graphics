//
//  AngleTests.swift
//  PathTools
//
//  Created by James Bean on 6/7/17.
//
//

import XCTest
import Geometry

class AngleTests: XCTestCase {

    func testAngleRadiansToDegrees() {
        XCTAssertEqual(Angle(radians: 0), Angle(degrees: 0))
        XCTAssertEqual(Angle(radians: .pi / 2), Angle(degrees: 90))
        XCTAssertEqual(Angle(radians: .pi), Angle(degrees: 180))
        XCTAssertEqual(Angle(radians: 3/2 * .pi), Angle(degrees: 270))
        XCTAssertEqual(Angle(radians: 2 * .pi), Angle(degrees: 360))
        XCTAssertEqual(Angle(radians: 7/2 * .pi), Angle(degrees: -90))
    }

    func testAngleDegrees() {
        XCTAssertEqual(Angle(degrees: 0).degrees, Angle(radians: 0).degrees)
        XCTAssertEqual(Angle(degrees: 90).degrees, Angle(radians: .pi / 2).degrees)
    }
}

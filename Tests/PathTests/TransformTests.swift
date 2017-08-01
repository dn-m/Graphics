//
//  TransformTests.swift
//  Path
//
//  Created by James Bean on 6/3/17.
//
//

import XCTest
import Geometry
import Path

class TransformTests: XCTestCase {
    
    func testRectangleTranslatedByZeroZeroEqual() {
        let a = Path.rectangle(origin: Point(), size: Size(width: 1, height: 1))
        let b = a.translatedBy(x: 0, y: 0)
        XCTAssertEqual(a, b)
    }
    
    func testRectangleTranslatedByALittleInBothDirectionsNotEqual() {
        let a = Path.rectangle(origin: Point(), size: Size(width: 1, height: 1))
        let b = a.translatedBy(x: 1, y: -1)
        XCTAssertNotEqual(a, b)
    }
}

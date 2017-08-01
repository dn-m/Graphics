//
//  ColorTests.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import XCTest
import Rendering

class ColorTests: XCTestCase {
    
    func testInitHexIntWhite() {
        let color = Color(hex: 0xFFFFFF, alpha: 1.0)
        XCTAssertEqual(color, Color(gray: 1, alpha: 1.0))
    }
    
    func testInitHexIntBlack() {
        let color = Color(hex: 0x0000000, alpha: 1.0)
        XCTAssertEqual(color, Color(gray: 0, alpha: 1.0))
    }
}

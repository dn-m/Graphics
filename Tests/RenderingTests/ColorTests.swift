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
        XCTAssertEqual(color, Color(white: 1, alpha: 1.0))
    }

    func testInitHexStringYellow() {
        let color = Color(hex: "#FFFF00", alpha: 1.0)
        XCTAssertEqual(color, Color(hex: 0xFFFF00, alpha: 1.0))
    }
    
    func testInitHexIntBlack() {
        let color = Color(hex: 0x0000000, alpha: 1.0)
        XCTAssertEqual(color, Color(white: 0, alpha: 1.0))
    }

    func testInitCMYKBlack() {
        let cmyk = Color(cyan: 0, magenta: 0, yellow: 0, black: 1)
        let rgb = Color(red: 0, green: 0, blue: 0)
        let hex = Color(hex: 0x000000)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKWhite() {
        let cmyk = Color(cyan: 0, magenta: 0, yellow: 0, black: 0)
        let rgb = Color(red: 255, green: 255, blue: 255)
        let hex = Color(hex: 0xFFFFFF)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKRed() {
        let cmyk = Color(cyan: 0, magenta: 1, yellow: 1, black: 0)
        let rgb = Color(red: 255, green: 0, blue: 0)
        let hex = Color(hex: 0xFF0000)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKGreen() {
        let cmyk = Color(cyan: 1, magenta: 0, yellow: 1, black: 0)
        let rgb = Color(red: 0, green: 255, blue: 0)
        let hex = Color(hex: 0x00FF00)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKBlue() {
        let cmyk = Color(cyan: 1, magenta: 1, yellow: 0, black: 0)
        let rgb = Color(red: 0, green: 0, blue: 255)
        let hex = Color(hex: 0x0000FF)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKYellow() {
        let cmyk = Color(cyan: 0, magenta: 0, yellow: 1, black: 0)
        let rgb = Color(red: 255, green: 255, blue: 0)
        let hex = Color(hex: 0xFFFF00)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKCyan() {
        let cmyk = Color(cyan: 1, magenta: 0, yellow: 0, black: 0)
        let rgb = Color(red: 0, green: 255, blue: 255)
        let hex = Color(hex: 0x00FFFF)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }

    func testInitCMYKMagenta() {
        let cmyk = Color(cyan: 0, magenta: 1, yellow: 0, black: 0)
        let rgb = Color(red: 255, green: 0, blue: 255)
        let hex = Color(hex: 0xFF00FF)
        XCTAssertEqual(cmyk, rgb)
        XCTAssertEqual(cmyk, hex)
    }
}

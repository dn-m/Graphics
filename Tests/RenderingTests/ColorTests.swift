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

    func assertColorsEqual(_ a: Color, _ b: Color, _ c: Color, _ d: Color) {
        XCTAssertEqual(a,b)
        XCTAssertEqual(b,c)
        XCTAssertEqual(c,d)
    }

    func testBlack() {
        let rgb = Color(red: 0, green: 0, blue: 0)
        let cmyk = Color(cyan: 0, magenta: 0, yellow: 0, black: 1)
        let hex = Color(hex: 0x000000)
        let hsv = Color(hue: 0, saturation: 0, value: 0)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testWhite() {
        let rgb = Color(red: 255, green: 255, blue: 255)
        let cmyk = Color(cyan: 0, magenta: 0, yellow: 0, black: 0)
        let hex = Color(hex: 0xFFFFFF)
        let hsv = Color(hue: 0, saturation: 0, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testRed() {
        let rgb = Color(red: 255, green: 0, blue: 0)
        let cmyk = Color(cyan: 0, magenta: 1, yellow: 1, black: 0)
        let hex = Color(hex: 0xFF0000)
        let hsv = Color(hue: 0, saturation: 1, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testGreen() {
        let rgb = Color(red: 0, green: 255, blue: 0)
        let cmyk = Color(cyan: 1, magenta: 0, yellow: 1, black: 0)
        let hex = Color(hex: 0x00FF00)
        let hsv = Color(hue: 120, saturation: 1, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testBlue() {
        let rgb = Color(red: 0, green: 0, blue: 255)
        let cmyk = Color(cyan: 1, magenta: 1, yellow: 0, black: 0)
        let hex = Color(hex: 0x0000FF)
        let hsv = Color(hue: 240, saturation: 1, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testYellow() {
        let rgb = Color(red: 255, green: 255, blue: 0)
        let cmyk = Color(cyan: 0, magenta: 0, yellow: 1, black: 0)
        let hex = Color(hex: 0xFFFF00)
        let hsv = Color(hue: 60, saturation: 1, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testCyan() {
        let cmyk = Color(cyan: 1, magenta: 0, yellow: 0, black: 0)
        let rgb = Color(red: 0, green: 255, blue: 255)
        let hex = Color(hex: 0x00FFFF)
        let hsv = Color(hue: 180, saturation: 1, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }

    func testMagenta() {
        let rgb = Color(red: 255, green: 0, blue: 255)
        let cmyk = Color(cyan: 0, magenta: 1, yellow: 0, black: 0)
        let hex = Color(hex: 0xFF00FF)
        let hsv = Color(hue: 300, saturation: 1, value: 1)
        assertColorsEqual(rgb,cmyk,hex,hsv)
    }
}

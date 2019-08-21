//
//  Color.swift
//  Rendering
//
//  Created by James Bean on 1/16/17.
//
//

import Math

/// Structure representing a color.
public struct Color {
    public let red: Double
    public let green: Double
    public let blue: Double
    public let alpha: Double

    /// Create a `Color` with the given `red`, `green`, `blue`, and `alpha` values.
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension Color {

    // MARK: - Initializers

    /// Create a `Color` with the given `red`, `green`, `blue`, and `alpha` values in the range
    /// [0,255].
    public init(red: Int, green: Int, blue: Int, alpha: Double = 1) {
        self.init(
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            alpha: alpha
        )
    }

    /// Create a `Color` with the given `cyan`, yellow`, `mageneta`, `black` and `alpha` values in
    /// the range [0,1].
    public init(cyan: Double, magenta: Double, yellow: Double, black: Double, alpha: Double = 1) {
        let red = (1 - cyan) * (1 - black)
        let green = (1 - magenta) * (1 - black)
        let blue = (1 - yellow) * (1 - black)
        self.init(red: red, green: green, blue: blue)
    }

    /// Create a `Color`, with the given `hue` in the range of [0,360], the given `saturation` in
    /// the range of [0,1], the given `value` in the range of [0,1], and the given `alpha` in the
    /// range of [0,1].
    public init(hue: Double, saturation: Double, value: Double, alpha: Double = 1) {

        let hue = mod(hue,360)
        let c = value * saturation
        let x = c * (1 - abs(mod(hue/60,2) - 1))
        let m = value - c

        var rgb: (Double,Double,Double) {
            switch hue {
            case 0..<60:
                return (c,x,0)
            case 60..<120:
                return (x,c,0)
            case 120..<180:
                return (0,c,x)
            case 180..<240:
                return (0,x,c)
            case 240..<300:
                return (x,0,c)
            case 300..<360:
                return (c,0,x)
            default:
                fatalError("Impossible")
            }
        }

        self.init(red: rgb.0 + m, green: rgb.1 + m, blue: rgb.2 + m)
    }

    /// Create a `Color` with the given `white` and `alpha` values.
    public init(white: Double, alpha: Double = 1) {
        self.init(red: white, green: white, blue: white, alpha: alpha)
    }

    /// Create a `Color` with the given `hex` hexadecimal integer, and the `alpha` value.
    public init(hex: Int, alpha: Double = 1) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: (hex) & 0xFF,
            alpha: alpha
        )
    }

    /// Create a `Color` with the given `hex` string, and the given `alpha` value.
    public init?(hex: String, alpha: Double) {
        let hexString = hex.droppingHash
        guard let hex = Int(hexString, radix: 16) else { return nil }
        self.init(hex: hex, alpha: alpha)
    }
}

extension Color {

    // MARK: - Nested Types

    /// The red, green, blue, and alpha components of this Color` in the range [0,1].
    public struct Components {
        public let red: Double
        public let green: Double
        public let blue: Double
        public let alpha: Double
    }
}

extension String {
    var droppingHash: String {
        guard first == "#" else { return self }
        return String(dropFirst())
    }
}

extension Color: Equatable { }
extension Color.Components: Equatable { }

extension Color {
    public static let aliceBlue = Color(hex: 0xF0F8FF, alpha: 1)
    public static let antiqueWhite = Color(hex: 0xFAEBD7, alpha: 1)
    public static let aqua = Color(hex: 0x00FFFF, alpha: 1)
    public static let aquamarine = Color(hex: 0x7FFFD4, alpha: 1)
    public static let azure = Color(hex: 0xF0FFFF, alpha: 1)
    public static let beige = Color(hex: 0xF5F5DC, alpha: 1)
    public static let bisque = Color(hex: 0xFFE4C4, alpha: 1)
    public static let black = Color(hex: 0x000000, alpha: 1)
    public static let blanchedAlmond = Color(hex: 0xFFEBCD, alpha: 1)
    public static let blue = Color(hex: 0x0000FF, alpha: 1)
    public static let blueViolet = Color(hex: 0x8A2BE2, alpha: 1)
    public static let brown = Color(hex: 0xA52A2A, alpha: 1)
    public static let burlyWood = Color(hex: 0xDEB887, alpha: 1)
    public static let cadetBlue = Color(hex: 0x5F9EA0, alpha: 1)
    public static let chartreuse = Color(hex: 0x7FFF00, alpha: 1)
    public static let chocolate = Color(hex: 0xD2691E, alpha: 1)
    public static let coral = Color(hex: 0xFF7F50, alpha: 1)
    public static let cornflowerBlue = Color(hex: 0x6495ED, alpha: 1)
    public static let cornsilk = Color(hex: 0xFFF8DC, alpha: 1)
    public static let crimson = Color(hex: 0xDC143C, alpha: 1)
    public static let cyan = Color(hex: 0x00FFFF, alpha: 1)
    public static let darkBlue = Color(hex: 0x00008B, alpha: 1)
    public static let darkCyan = Color(hex: 0x008B8B, alpha: 1)
    public static let darkGoldenRod = Color(hex: 0xB8860B, alpha: 1)
    public static let darkGray = Color(hex: 0xA9A9A9, alpha: 1)
    public static let darkGrey = Color(hex: 0xA9A9A9, alpha: 1)
    public static let darkGreen = Color(hex: 0x006400, alpha: 1)
    public static let darkKhaki = Color(hex: 0xBDB76B, alpha: 1)
    public static let darkMagenta = Color(hex: 0x8B008B, alpha: 1)
    public static let darkOliveGreen = Color(hex: 0x556B2F, alpha: 1)
    public static let darkOrange = Color(hex: 0xFF8C00, alpha: 1)
    public static let darkOrchid = Color(hex: 0x9932CC, alpha: 1)
    public static let darkRed = Color(hex: 0x8B0000, alpha: 1)
    public static let darkSalmon = Color(hex: 0xE9967A, alpha: 1)
    public static let darkSeaGreen = Color(hex: 0x8FBC8F, alpha: 1)
    public static let darkSlateBlue = Color(hex: 0x483D8B, alpha: 1)
    public static let darkSlateGray = Color(hex: 0x2F4F4F, alpha: 1)
    public static let darkSlateGrey = Color(hex: 0x2F4F4F, alpha: 1)
    public static let darkTurquoise = Color(hex: 0x00CED1, alpha: 1)
    public static let darkViolet = Color(hex: 0x9400D3, alpha: 1)
    public static let deepPink = Color(hex: 0xFF1493, alpha: 1)
    public static let deepSkyBlue = Color(hex: 0x00BFFF, alpha: 1)
    public static let dimGray = Color(hex: 0x696969, alpha: 1)
    public static let dimGrey = Color(hex: 0x696969, alpha: 1)
    public static let dodgerBlue = Color(hex: 0x1E90FF, alpha: 1)
    public static let fireBrick = Color(hex: 0xB22222, alpha: 1)
    public static let floralWhite = Color(hex: 0xFFFAF0, alpha: 1)
    public static let forestGreen = Color(hex: 0x228B22, alpha: 1)
    public static let fuchsia = Color(hex: 0xFF00FF, alpha: 1)
    public static let gainsboro = Color(hex: 0xDCDCDC, alpha: 1)
    public static let ghostWhite = Color(hex: 0xF8F8FF, alpha: 1)
    public static let gold = Color(hex: 0xFFD700, alpha: 1)
    public static let goldenRod = Color(hex: 0xDAA520, alpha: 1)
    public static let gray = Color(hex: 0x808080, alpha: 1)
    public static let grey = Color(hex: 0x808080, alpha: 1)
    public static let green = Color(hex: 0x008000, alpha: 1)
    public static let greenYellow = Color(hex: 0xADFF2F, alpha: 1)
    public static let honeyDew = Color(hex: 0xF0FFF0, alpha: 1)
    public static let hotPink = Color(hex: 0xFF69B4, alpha: 1)
    public static let indianRed = Color(hex: 0xCD5C5C, alpha: 1)
    public static let indigo = Color(hex: 0x4B0082, alpha: 1)
    public static let ivory = Color(hex: 0xFFFFF0, alpha: 1)
    public static let khaki = Color(hex: 0xF0E68C, alpha: 1)
    public static let lavender = Color(hex: 0xE6E6FA, alpha: 1)
    public static let lavenderBlush = Color(hex: 0xFFF0F5, alpha: 1)
    public static let lawnGreen = Color(hex: 0x7CFC00, alpha: 1)
    public static let lemonChiffon = Color(hex: 0xFFFACD, alpha: 1)
    public static let lightBlue = Color(hex: 0xADD8E6, alpha: 1)
    public static let lightCoral = Color(hex: 0xF08080, alpha: 1)
    public static let lightCyan = Color(hex: 0xE0FFFF, alpha: 1)
    public static let lightGoldenRodYellow = Color(hex: 0xFAFAD2, alpha: 1)
    public static let lightGray = Color(hex: 0xD3D3D3, alpha: 1)
    public static let lightGrey = Color(hex: 0xD3D3D3, alpha: 1)
    public static let lightGreen = Color(hex: 0x90EE90, alpha: 1)
    public static let lightPink = Color(hex: 0xFFB6C1, alpha: 1)
    public static let lightSalmon = Color(hex: 0xFFA07A, alpha: 1)
    public static let lightSeaGreen = Color(hex: 0x20B2AA, alpha: 1)
    public static let lightSkyBlue = Color(hex: 0x87CEFA, alpha: 1)
    public static let lightSlateGray = Color(hex: 0x778899, alpha: 1)
    public static let lightSlateGrey = Color(hex: 0x778899, alpha: 1)
    public static let lightSteelBlue = Color(hex: 0xB0C4DE, alpha: 1)
    public static let lightYellow = Color(hex: 0xFFFFE0, alpha: 1)
    public static let lime = Color(hex: 0x00FF00, alpha: 1)
    public static let limeGreen = Color(hex: 0x32CD32, alpha: 1)
    public static let linen = Color(hex: 0xFAF0E6, alpha: 1)
    public static let magenta = Color(hex: 0xFF00FF, alpha: 1)
    public static let maroon = Color(hex: 0x800000, alpha: 1)
    public static let mediumAquaMarine = Color(hex: 0x66CDAA, alpha: 1)
    public static let mediumBlue = Color(hex: 0x0000CD, alpha: 1)
    public static let mediumOrchid = Color(hex: 0xBA55D3, alpha: 1)
    public static let mediumPurple = Color(hex: 0x9370D8, alpha: 1)
    public static let mediumSeaGreen = Color(hex: 0x3CB371, alpha: 1)
    public static let mediumSlateBlue = Color(hex: 0x7B68EE, alpha: 1)
    public static let mediumSpringGreen = Color(hex: 0x00FA9A, alpha: 1)
    public static let mediumTurquoise = Color(hex: 0x48D1CC, alpha: 1)
    public static let mediumVioletRed = Color(hex: 0xC71585, alpha: 1)
    public static let midnightBlue = Color(hex: 0x191970, alpha: 1)
    public static let mintCream = Color(hex: 0xF5FFFA, alpha: 1)
    public static let mistyRose = Color(hex: 0xFFE4E1, alpha: 1)
    public static let moccasin = Color(hex: 0xFFE4B5, alpha: 1)
    public static let navajoWhite = Color(hex: 0xFFDEAD, alpha: 1)
    public static let navy = Color(hex: 0x000080, alpha: 1)
    public static let oldLace = Color(hex: 0xFDF5E6, alpha: 1)
    public static let olive = Color(hex: 0x808000, alpha: 1)
    public static let oliveDrab = Color(hex: 0x6B8E23, alpha: 1)
    public static let orange = Color(hex: 0xFFA500, alpha: 1)
    public static let orangeRed = Color(hex: 0xFF4500, alpha: 1)
    public static let orchid = Color(hex: 0xDA70D6, alpha: 1)
    public static let paleGoldenRod = Color(hex: 0xEEE8AA, alpha: 1)
    public static let paleGreen = Color(hex: 0x98FB98, alpha: 1)
    public static let paleTurquoise = Color(hex: 0xAFEEEE, alpha: 1)
    public static let paleVioletRed = Color(hex: 0xD87093, alpha: 1)
    public static let papayaWhip = Color(hex: 0xFFEFD5, alpha: 1)
    public static let peachPuff = Color(hex: 0xFFDAB9, alpha: 1)
    public static let peru = Color(hex: 0xCD853F, alpha: 1)
    public static let pink = Color(hex: 0xFFC0CB, alpha: 1)
    public static let plum = Color(hex: 0xDDA0DD, alpha: 1)
    public static let powderBlue = Color(hex: 0xB0E0E6, alpha: 1)
    public static let purple = Color(hex: 0x800080, alpha: 1)
    public static let red = Color(hex: 0xFF0000, alpha: 1)
    public static let rosyBrown = Color(hex: 0xBC8F8F, alpha: 1)
    public static let royalBlue = Color(hex: 0x4169E1, alpha: 1)
    public static let saddleBrown = Color(hex: 0x8B4513, alpha: 1)
    public static let salmon = Color(hex: 0xFA8072, alpha: 1)
    public static let sandyBrown = Color(hex: 0xF4A460, alpha: 1)
    public static let seaGreen = Color(hex: 0x2E8B57, alpha: 1)
    public static let seaShell = Color(hex: 0xFFF5EE, alpha: 1)
    public static let sienna = Color(hex: 0xA0522D, alpha: 1)
    public static let silver = Color(hex: 0xC0C0C0, alpha: 1)
    public static let skyBlue = Color(hex: 0x87CEEB, alpha: 1)
    public static let slateBlue = Color(hex: 0x6A5ACD, alpha: 1)
    public static let slateGray = Color(hex: 0x708090, alpha: 1)
    public static let slateGrey = Color(hex: 0x708090, alpha: 1)
    public static let snow = Color(hex: 0xFFFAFA, alpha: 1)
    public static let springGreen = Color(hex: 0x00FF7F, alpha: 1)
    public static let steelBlue = Color(hex: 0x4682B4, alpha: 1)
    public static let tan = Color(hex: 0xD2B48C, alpha: 1)
    public static let teal = Color(hex: 0x008080, alpha: 1)
    public static let thistle = Color(hex: 0xD8BFD8, alpha: 1)
    public static let tomato = Color(hex: 0xFF6347, alpha: 1)
    public static let turquoise = Color(hex: 0x40E0D0, alpha: 1)
    public static let violet = Color(hex: 0xEE82EE, alpha: 1)
    public static let wheat = Color(hex: 0xF5DEB3, alpha: 1)
    public static let white = Color(hex: 0xFFFFFF, alpha: 1)
    public static let whiteSmoke = Color(hex: 0xF5F5F5, alpha: 1)
    public static let yellow = Color(hex: 0xFFFF00, alpha: 1)
    public static let yellowGreen = Color(hex: 0x9ACD32, alpha: 1)
}

extension Color: CustomStringConvertible {

    public var description: String {
        return "(" +
            zip(["r","g","b","a"],[red,green,blue,alpha])
                .map { "\($0): \($1)" }
                .joined(separator: ", ") +
            ")"
    }
}

import XCTest

extension CubicBezierCurveTests {
    static let __allTests = [
        ("testLength", testLength),
        ("testSimplify", testSimplify),
        ("testSlopeDown", testSlopeDown),
        ("testSlopeUp", testSlopeUp),
        ("testSplit", testSplit),
        ("testUpAndDown", testUpAndDown),
        ("testXsAtY", testXsAtY),
        ("testYsAtX", testYsAtX),
    ]
}

extension EllipseTests {
    static let __allTests = [
        ("testEllipse", testEllipse),
    ]
}

extension LinearBezierCurveTests {
    static let __allTests = [
        ("testInit", testInit),
        ("testPointAtT", testPointAtT),
        ("testXsAtY", testXsAtY),
        ("testYsAtX", testYsAtX),
    ]
}

extension PathElementTests {
    static let __allTests = [
        ("testCurve", testCurve),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testQuadCurve", testQuadCurve),
    ]
}

extension PathTests {
    static let __allTests = [
        ("testAddCurve", testAddCurve),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testInitWithCGRect", testInitWithCGRect),
        ("testMoveTo", testMoveTo),
        ("testMoveToLineTo", testMoveToLineTo),
        ("testSimplified", testSimplified),
    ]
}

extension QuadraticBezierCurveTests {
    static let __allTests = [
        ("testXsAtY", testXsAtY),
        ("testYsAtX", testYsAtX),
    ]
}

extension TransformTests {
    static let __allTests = [
        ("testRectangleTranslatedByALittleInBothDirectionsNotEqual", testRectangleTranslatedByALittleInBothDirectionsNotEqual),
        ("testRectangleTranslatedByZeroZeroEqual", testRectangleTranslatedByZeroZeroEqual),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CubicBezierCurveTests.__allTests),
        testCase(EllipseTests.__allTests),
        testCase(LinearBezierCurveTests.__allTests),
        testCase(PathElementTests.__allTests),
        testCase(PathTests.__allTests),
        testCase(QuadraticBezierCurveTests.__allTests),
        testCase(TransformTests.__allTests),
    ]
}
#endif

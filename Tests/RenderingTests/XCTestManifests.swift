import XCTest

extension ColorTests {
    static let __allTests = [
        ("testInitHexIntBlack", testInitHexIntBlack),
        ("testInitHexIntWhite", testInitHexIntWhite),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ColorTests.__allTests),
    ]
}
#endif

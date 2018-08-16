import XCTest

extension ColorTests {
    static let __allTests = [
        ("testBlack", testBlack),
        ("testBlue", testBlue),
        ("testCyan", testCyan),
        ("testGreen", testGreen),
        ("testInitHexIntBlack", testInitHexIntBlack),
        ("testInitHexIntWhite", testInitHexIntWhite),
        ("testInitHexStringYellow", testInitHexStringYellow),
        ("testMagenta", testMagenta),
        ("testRed", testRed),
        ("testWhite", testWhite),
        ("testYellow", testYellow),
    ]
}

extension CompositeTests {
    static let __allTests = [
        ("testBranchAllZeroFramedLeaves", testBranchAllZeroFramedLeaves),
        ("testBranchAllZeroFramedLeavesButNonZeroGroup", testBranchAllZeroFramedLeavesButNonZeroGroup),
        ("testLeafAxisAlignedBoundingBox", testLeafAxisAlignedBoundingBox),
        ("testLeafAxisAlignedBoundingBoxNonZeroFrame", testLeafAxisAlignedBoundingBoxNonZeroFrame),
        ("testResizedToFitContentsBranchScaleAndTranslation", testResizedToFitContentsBranchScaleAndTranslation),
        ("testResizedToFitContentsBranchScaleAndTranslation2", testResizedToFitContentsBranchScaleAndTranslation2),
        ("testResizedToFitContentsLeafNoChange", testResizedToFitContentsLeafNoChange),
        ("testResizedToFitContentsLeafNoTranslation", testResizedToFitContentsLeafNoTranslation),
        ("testResizedToFitContentsLeafScaleAndTranslation", testResizedToFitContentsLeafScaleAndTranslation),
        ("testTranslateGroup", testTranslateGroup),
        ("testTranslateLeaf", testTranslateLeaf),
    ]
}

extension StyledPathTests {
    static let __allTests = [
        ("testResizedToFitContents", testResizedToFitContents),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ColorTests.__allTests),
        testCase(CompositeTests.__allTests),
        testCase(StyledPathTests.__allTests),
    ]
}
#endif

import XCTest

extension AngleTests {
    static let __allTests = [
        ("testAngleDegrees", testAngleDegrees),
        ("testAngleRadiansToDegrees", testAngleRadiansToDegrees),
    ]
}

extension CollisionDetectionTests {
    static let __allTests = [
        ("testContainsPointInRectFalse", testContainsPointInRectFalse),
        ("testContainsPointInRectTrue", testContainsPointInRectTrue),
        ("testConvexHull", testConvexHull),
        ("testEqualRectsIntersectingTrue", testEqualRectsIntersectingTrue),
        ("testPolygonContainsPointFalse", testPolygonContainsPointFalse),
        ("testPolygonContainsPointTrue", testPolygonContainsPointTrue),
        ("testRectangleDiamondSeparatedIntersectingFalse", testRectangleDiamondSeparatedIntersectingFalse),
        ("testRectsSeparatedAboveIntersectingFalse", testRectsSeparatedAboveIntersectingFalse),
        ("testXsAtYRect", testXsAtYRect),
        ("testYsAtXRect", testYsAtXRect),
    ]
}

extension LineTests {
    static let __allTests = [
        ("testHorizontalLinePerpendicular", testHorizontalLinePerpendicular),
        ("testInitWithSegment", testInitWithSegment),
        ("testLineLengthHorizontal", testLineLengthHorizontal),
        ("testLineLengthPositiveDiagonal", testLineLengthPositiveDiagonal),
        ("testLineLengthVertical", testLineLengthVertical),
        ("testRayInitWithSegmentHorizontalLeft", testRayInitWithSegmentHorizontalLeft),
        ("testRayInitWithSegmentHorizontalRight", testRayInitWithSegmentHorizontalRight),
        ("testRayInitWithSegmentVerticalDown", testRayInitWithSegmentVerticalDown),
        ("testRayInitWithSegmentVerticalUp", testRayInitWithSegmentVerticalUp),
        ("testRayPointAtDistance", testRayPointAtDistance),
        ("testRayPointAtDistanceHorizontal", testRayPointAtDistanceHorizontal),
        ("testRayPointAtDistanceVertical", testRayPointAtDistanceVertical),
        ("testSlantedLinePerpendicular", testSlantedLinePerpendicular),
        ("testVerticalLinePerpendicular", testVerticalLinePerpendicular),
    ]
}

extension PointTests {
    static let __allTests = [
        ("testDistanceTo", testDistanceTo),
        ("testPointAddition", testPointAddition),
        ("testPointDivision", testPointDivision),
        ("testPointMultiply", testPointMultiply),
        ("testPointSubtraction", testPointSubtraction),
        ("testReflectedOverLine", testReflectedOverLine),
        ("testReflectedOverXAxis", testReflectedOverXAxis),
        ("testReflectedOverYAxis", testReflectedOverYAxis),
        ("testRotated90DegreesAroundOrigin", testRotated90DegreesAroundOrigin),
        ("testRotated90DegressAroundPoint", testRotated90DegressAroundPoint),
        ("testRotateNoChange", testRotateNoChange),
        ("testScaledDoubleFromOrigin", testScaledDoubleFromOrigin),
        ("testScaledNoChange", testScaledNoChange),
        ("testScaledTripleFromReferencePoint", testScaledTripleFromReferencePoint),
        ("testValueForAxis", testValueForAxis),
    ]
}

extension PolygonTests {
    static let __allTests = [
        ("testBlockCTriangulated", testBlockCTriangulated),
        ("testBlockCTriangulatedClockwise", testBlockCTriangulatedClockwise),
        ("testConvexityFalse", testConvexityFalse),
        ("testHouseTriangulated", testHouseTriangulated),
        ("testPentagonConvexityTrue", testPentagonConvexityTrue),
        ("testPolygonOrderClockwise", testPolygonOrderClockwise),
        ("testPolygonOrderCounterClockwise", testPolygonOrderCounterClockwise),
        ("testReduce", testReduce),
        ("testSquareConvexityTrue", testSquareConvexityTrue),
        ("testSquareTriangulated", testSquareTriangulated),
        ("testSum", testSum),
        ("testTriangleContainsPointFalse", testTriangleContainsPointFalse),
        ("testTriangleContainsPointTrue", testTriangleContainsPointTrue),
        ("testTriangleEqualToTriangulatedSelf", testTriangleEqualToTriangulatedSelf),
        ("testVertexConvexFalse", testVertexConvexFalse),
        ("testVertexConvexTrue", testVertexConvexTrue),
    ]
}

extension RectangleTests {
    static let __allTests = [
        ("testNormalizedFlipX", testNormalizedFlipX),
        ("testNormalizedFlipXAndY", testNormalizedFlipXAndY),
        ("testNormalizedFlipY", testNormalizedFlipY),
        ("testNormalizedIdentity", testNormalizedIdentity),
        ("testRectangleNonEmptySum", testRectangleNonEmptySum),
        ("testRectangleSum", testRectangleSum),
        ("testScaled", testScaled),
        ("testScaledAroundCenter", testScaledAroundCenter),
        ("testScaledBy", testScaledBy),
        ("testScaledByAroundCenter", testScaledByAroundCenter),
        ("testScaledByHeightOnly", testScaledByHeightOnly),
        ("testScaledByHeightOnlyAroundCenter", testScaledByHeightOnlyAroundCenter),
        ("testScaledByWidthOnly", testScaledByWidthOnly),
        ("testScaledByWidthOnlyAroundCenter", testScaledByWidthOnlyAroundCenter),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AngleTests.__allTests),
        testCase(CollisionDetectionTests.__allTests),
        testCase(LineTests.__allTests),
        testCase(PointTests.__allTests),
        testCase(PolygonTests.__allTests),
        testCase(RectangleTests.__allTests),
    ]
}
#endif

//
//  CompositeTests.swift
//  Rendering
//
//  Created by James Bean on 7/2/17.
//
//

import Geometry
import Path
import Rendering
import GraphicsTesting
import XCTest

#if os(macOS)
import QuartzCore
#endif

class CompositeTests: XCTestCase {

    override func setUp() {
        createArtifactsDirectory(for: "\(type(of: self))")
    }

    override func tearDown() {
        openArtifactsDirectory()
    }

    func testTranslateLeaf() {
        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
        let path = Path.circle(center: Point(), radius: 10)
        let styled = StyledPath(frame: frame, path: path, styling: Styling(fill: Fill(color: .black)))
        let leaf = StyledPath.Composite.leaf(.path(styled))
        let translated = leaf.translated(by: Point(x: 10, y: 10))
        let expected = Rectangle(x: 20, y: 20, width: 100, height: 100)
        XCTAssertEqual(translated.frame, expected)
    }

    func testTranslateGroup() {
        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
        let group = Group(frame: frame)
        let path = Path.circle(center: Point(), radius: 10)
        let styled = StyledPath(frame: frame, path: path, styling: Styling(fill: Fill(color: .black)))
        let leaf = StyledPath.Composite.leaf(.path(styled))
        let branch = StyledPath.Composite.branch(group, [leaf])
        let translated = branch.translated(by: Point(x: 10, y: 10))
        let expected = Rectangle(x: 20, y: 20, width: 100, height: 100)
        XCTAssertEqual(translated.frame, expected)
    }

    func testLeafAxisAlignedBoundingBox() {
        let path = Path.circle(center: Point(), radius: 10)
        let composite = StyledPath.Composite.leaf(.path(StyledPath(path: path)))
        let bbox = composite.axisAlignedBoundingBox
        let expected = Rectangle(x: -10, y: -10, width: 20, height: 20)
        XCTAssertEqual(bbox, expected)
    }

    func testLeafAxisAlignedBoundingBoxNonZeroFrame() {
        let frame = Rectangle(origin: Point(x: 10, y: 10))
        let path = Path.circle(center: Point(), radius: 10)
        let styled = StyledPath(frame: frame, path: path, styling: Styling(fill: Fill(color: .black)))
        let composite = StyledPath.Composite.leaf(.path(styled))
        let bbox = composite.axisAlignedBoundingBox
        let expected = Rectangle(x: -20, y: -20, width: 20, height: 20)
        XCTAssertEqual(bbox, expected)
    }

    func testBranchAllZeroFramedLeaves() {

        // bbox: (0,0),20,100
        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 10))
        let styledA = StyledPath(path: a, styling: Styling(stroke: Stroke(color: .black)))

        // bbox: (-15,-15),40,40
        let b = Path.circle(center: Point(x: 5, y: 5), radius: 20)
        let styledB = StyledPath(path: b, styling: Styling(stroke: Stroke(color: .black)))
        let composite = StyledPath.Composite.branch(
            Group(), [
                .leaf(.path(styledA)),
                .leaf(.path(styledB))
            ]
        )
        let bbox = composite.axisAlignedBoundingBox
        let expected = Rectangle(x: -15, y: -15, width: 115, height: 40)
        XCTAssertEqual(bbox, expected)
    }

    func testBranchAllZeroFramedLeavesButNonZeroGroup() {

        // bbox: (0,0),20,100
        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 10))
        let styledA = StyledPath(path: a, styling: Styling(stroke: Stroke(color: .black)))

        // bbox: (-15,-15),40,40
        let b = Path.circle(center: Point(x: 5, y: 5), radius: 20)
        let styledB = StyledPath(path: b, styling: Styling(fill: Fill(color: .black)))

        let group = Group(frame: Rectangle(origin: Point(x: 1, y: 1)))
        let composite = StyledPath.Composite.branch(
            group, [
                .leaf(.path(styledA)),
                .leaf(.path(styledB))
            ]
        )

        let bbox = composite.axisAlignedBoundingBox
        let expected = Rectangle(x: -16, y: -16, width: 115, height: 40)

        XCTAssertEqual(bbox, expected)
    }

    func testResizedToFitContentsLeafNoChange() {
        let rect = Rectangle(width: 10, height: 10)
        let styling = Styling(fill: Fill(color: .black))
        let styled = StyledPath(frame: rect, path: Path.rectangle(rect), styling: styling)
        let composite = StyledPath.Composite.leaf(.path(styled))
        let resized = composite.resizedToFitContents
        XCTAssertEqual(resized.frame, rect)
        render(composite, fileName: "\(#function)_before", testCaseName: "\(type(of: self))")
        render(resized, fileName: "\(#function)_after", testCaseName: "\(type(of: self))")
    }

    func testResizedToFitContentsLeafNoTranslation() {
        let rect = Rectangle(width: 10, height: 10)
        let styling = Styling(stroke: Stroke(color: .black))
        let renderedPath = StyledPath(frame: .zero, path: Path.rectangle(rect), styling: styling)
        let composite = StyledPath.Composite.leaf(.path(renderedPath))
        let resized = composite.resizedToFitContents
        XCTAssertEqual(resized.frame, rect)
        render(composite, fileName: "\(#function)_before", testCaseName: "\(type(of: self))")
        render(resized, fileName: "\(#function)_after", testCaseName: "\(type(of: self))")
    }

    func testResizedToFitContentsLeafScaleAndTranslation() {
        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
        let path = Path.rectangle(x: 5, y: 5, width: 10, height: 10)
        let styled = StyledPath(frame: frame, path: path, styling: Styling(fill: Fill(color: .black)))
        let composite = StyledPath.Composite.leaf(.path(styled))
        let resized = composite.resizedToFitContents
        let expected = Rectangle(x: 5, y: 5, width: 10, height: 10)
        XCTAssertEqual(resized.frame, expected)
        render(composite, fileName: "\(#function)_before", testCaseName: "\(type(of: self))")
        render(resized, fileName: "\(#function)_after", testCaseName: "\(type(of: self))")
    }

    func testResizedToFitContentsBranchScaleAndTranslation() {

        let group = Group(frame: Rectangle(x: 5, y: 5, width: 100, height: 100))

        // Offset by 0,0 in own coordinates
        let a = Path.rectangle(x: 0, y: 0, width: 3, height: 3)

        // Offset by 20,20 in parent coordinates
        let styledA = StyledPath(
            frame: Rectangle(x: 20, y: 20, width: 4, height: 4),
            path: a,
            styling: Styling(stroke: Stroke(color: .black))
        )

        // Offset by 5,5 in own coordinates
        let b = Path.rectangle(x: 5, y: 5, width: 5, height: 5)

        // Offset by 2,2 in parent coordinates
        let styledB = StyledPath(
            frame: Rectangle(x: 2, y: 2, width: 10, height: 10),
            path: b,
            styling: Styling(fill: Fill(color: .black))
        )

        let composite = StyledPath.Composite.branch(group, [
            .leaf(.path(styledA)),
            .leaf(.path(styledB))
        ])
        let resized = composite.resizedToFitContents
        let expected = Rectangle(x: 2, y: 2, width: 22, height: 22)
        XCTAssertEqual(resized.frame, expected)
        render(composite, fileName: "\(#function)_before", testCaseName: "\(type(of: self))")
        render(resized, fileName: "\(#function)_after", testCaseName: "\(type(of: self))")
    }

    func testResizedToFitContentsBranchScaleAndTranslation2() {

        let group = Group(frame: Rectangle(x: 0, y: 0, width: 100, height: 100))

        // Offset by 0,0 in own coordinates
        let a = Path.rectangle(x: 0, y: 0, width: 3, height: 3)

        // Offset by 0,0 in parent coordinates
        let styledA = StyledPath(
            frame: Rectangle(x: 0, y: 0, width: 3, height: 3),
            path: a,
            styling: Styling(fill: Fill(color: .black))
        )

        // Offset by 0,0 in own coordinates
        let b = Path.rectangle(x: 0, y: 0, width: 10, height: 10)

        // Offset by 20,20 in parent coordinates
        let styledB = StyledPath(
            frame: Rectangle(x: 20, y: 20, width: 10, height: 10),
            path: b,
            styling: Styling(stroke: Stroke(color: .black))
        )

        let composite = StyledPath.Composite.branch(group, [
            .leaf(.path(styledA)),
            .leaf(.path(styledB))
        ])
        let resized = composite.resizedToFitContents
        let expected = Rectangle(x: 0, y: 0, width: 30, height: 30)
        XCTAssertEqual(resized.frame, expected)
        render(composite, fileName: "\(#function)_before", testCaseName: "\(type(of: self))")
        render(resized, fileName: "\(#function)_after", testCaseName: "\(type(of: self))")
    }

    func testBezierCurveTopLeftBottomRightEaseInEaseOut() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 0),
            control1: Point(x: 50, y: 0),
            control2: Point(x: 50, y: 100),
            end: Point(x: 100, y: 100)
        )
        let path = Path(curve)
        let styledPath = StyledPath(
            frame: frame,
            path: path,
            styling: Styling(stroke: Stroke(color: .black))
        )
        let composite: StyledPath.Composite = .branch(group, [.leaf(.path(styledPath))])
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }

    func testBezierCurveBottomLeftTopRightEaseInEaseOut() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 100),
            control1: Point(x: 50, y: 100),
            control2: Point(x: 50, y: 0),
            end: Point(x: 100, y: 0)
        )
        let path = Path(curve)
        let styledPath = StyledPath(
            frame: frame,
            path: path,
            styling: Styling(stroke: Stroke(color: .black))
        )
        let composite: StyledPath.Composite = .branch(group, [.leaf(.path(styledPath))])
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }

    func testBezierCurveRedDotsLinearT() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 100),
            control1: Point(x: 50, y: 100),
            control2: Point(x: 50, y: 0),
            end: Point(x: 100, y: 0)
        )
        let dots = stride(from: 0.0, through: 1, by: 0.1).map { t -> StyledPath.Composite in
            let dotPath = Path.circle(center: curve[t], radius: 2)
            let styledDotPath = StyledPath(
                frame: frame,
                path: dotPath,
                styling: Styling(fill: Fill(color: .red))
            )
            return .leaf(Item.path(styledDotPath))
        }

        let path = Path(curve)
        let styledPath = StyledPath(
            frame: frame,
            path: path,
            styling: Styling(stroke: Stroke(color: .black))
        )
        let composite: StyledPath.Composite = .branch(group, [.leaf(.path(styledPath))] + dots)
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }

    func testBezierCurveRedDotsLinearX() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 100),
            control1: Point(x: 50, y: 100),
            control2: Point(x: 50, y: 0),
            end: Point(x: 100, y: 0)
        )
        let dots = stride(from: 0.0, through: 100, by: 10).map { x -> StyledPath.Composite in
            let y = curve.ys(x: x).first!
            let dotPath = Path.circle(center: Point(x: x,y: y), radius: 2)
            let styledDotPath = StyledPath(
                frame: frame,
                path: dotPath,
                styling: Styling(fill: Fill(color: .red))
            )
            return .leaf(Item.path(styledDotPath))
        }

        let path = Path(curve)
        let styledPath = StyledPath(
            frame: frame,
            path: path,
            styling: Styling(stroke: Stroke(color: .black))
        )
        let composite: StyledPath.Composite = .branch(group, [.leaf(.path(styledPath))] + dots)
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }

    func testBezierCurveRedDotsLinearY() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 100),
            control1: Point(x: 50, y: 100),
            control2: Point(x: 50, y: 0),
            end: Point(x: 100, y: 0)
        )
        let dots = stride(from: 0.0, through: 100, by: 10).map { y -> StyledPath.Composite in
            let xs = curve.xs(y: y)
            let x = xs.filter { (0...100).contains($0) }.first!
            let dotPath = Path.circle(center: Point(x: x,y: y), radius: 2)
            let styledDotPath = StyledPath(
                frame: frame,
                path: dotPath,
                styling: Styling(fill: Fill(color: .red))
            )
            return .leaf(Item.path(styledDotPath))
        }

        let path = Path(curve)
        let styledPath = StyledPath(
            frame: frame,
            path: path,
            styling: Styling(stroke: Stroke(color: .black))
        )
        let composite: StyledPath.Composite = .branch(group, [.leaf(.path(styledPath))] + dots)
        render(composite, fileName: "\(#function)", testCaseName: "\(type(of: self))")
    }
}

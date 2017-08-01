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

import XCTest

// FIXME: Reintroduce
//import GraphicsTestTools

//class CompositeTests: GraphicsTestCase {
//
//    func testTranslateLeaf() {
//        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
//        let path = Path.circle(center: Point(), radius: 10)
//        let styled = StyledPath(frame: frame, path: path)
//        let leaf = Composite.leaf(.path(styled))
//        let translated = leaf.translated(by: Point(x: 10, y: 10))
//        let expected = Rectangle(x: 20, y: 20, width: 100, height: 100)
//        XCTAssertEqual(translated.frame, expected)
//    }
//
//    func testTranslateGroup() {
//        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
//        let group = Group(frame: frame)
//        let path = Path.circle(center: Point(), radius: 10)
//        let styled = StyledPath(frame: frame, path: path)
//        let leaf = Composite.leaf(.path(styled))
//        let branch = Composite.branch(group, [leaf])
//        let translated = branch.translated(by: Point(x: 10, y: 10))
//        let expected = Rectangle(x: 20, y: 20, width: 100, height: 100)
//        XCTAssertEqual(translated.frame, expected)
//    }
//
//    func testLeafAxisAlignedBoundingBox() {
//        let path = Path.circle(center: Point(), radius: 10)
//        let composite = Composite.leaf(.path(StyledPath(path: path)))
//        let bbox = composite.axisAlignedBoundingBox
//        let expected = Rectangle(x: -10, y: -10, width: 20, height: 20)
//        XCTAssertEqual(bbox, expected)
//    }
//
//    func testLeafAxisAlignedBoundingBoxNonZeroFrame() {
//
//        let path = Path.circle(center: Point(), radius: 10)
//
//        let styledPath = StyledPath(
//            frame: Rectangle(origin: Point(x: 10, y: 10)),
//            path: path
//        )
//
//        let composite = Composite.leaf(.path(styledPath))
//        let bbox = composite.axisAlignedBoundingBox
//        let expected = Rectangle(x: -20, y: -20, width: 20, height: 20)
//        XCTAssertEqual(bbox, expected)
//    }
//
//    func testBranchAllZeroFramedLeaves() {
//
//        // bbox: (0,0),20,100
//        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 10))
//        let styledA = StyledPath(path: a)
//
//        // bbox: (-15,-15),40,40
//        let b = Path.circle(center: Point(x: 5, y: 5), radius: 20)
//        let styledB = StyledPath(path: b)
//
//        let composite = Composite.branch(
//            Group(), [
//                .leaf(.path(styledA)),
//                .leaf(.path(styledB))
//            ]
//        )
//
//        let bbox = composite.axisAlignedBoundingBox
//        let expected = Rectangle(x: -15, y: -15, width: 115, height: 40)
//        XCTAssertEqual(bbox, expected)
//    }
//
//    func testBranchAllZeroFramedLeavesButNonZeroGroup() {
//
//        // bbox: (0,0),20,100
//        let a = Path.rectangle(origin: Point(), size: Size(width: 100, height: 10))
//        let styledA = StyledPath(path: a)
//
//        // bbox: (-15,-15),40,40
//        let b = Path.circle(center: Point(x: 5, y: 5), radius: 20)
//        let styledB = StyledPath(path: b)
//
//        let group = Group(frame: Rectangle(origin: Point(x: 1, y: 1)))
//        let composite = Composite.branch(
//            group, [
//                .leaf(.path(styledA)),
//                .leaf(.path(styledB))
//            ]
//        )
//
//        let bbox = composite.axisAlignedBoundingBox
//        let expected = Rectangle(x: -16, y: -16, width: 115, height: 40)
//
//        XCTAssertEqual(bbox, expected)
//    }
//
//    func testResizedToFitContentsLeafNoChange() {
//
//        let rect = Rectangle(width: 10, height: 10)
//        let styledPath = StyledPath(frame: rect, path: Path.rectangle(rect))
//        let composite = Composite.leaf(.path(styledPath))
//        let resized = composite.resizedToFitContents
//
//        // Assert logic
//        XCTAssertEqual(resized.frame, rect)
//
//        // Check graphics
//        let before = CALayer(composite)
//        before.showTestBorder()
//        render(before, name: "testResizedToFitContentsLeafNoChange_before")
//
//        let after = CALayer(resized)
//        after.showTestBorder()
//        render(after, name: "testResizedToFitContentsLeafNoChange_after")
//    }
//
//    func testResizedToFitContentsLeafNoTranslation() {
//
//        let rect = Rectangle(width: 10, height: 10)
//        let styledPath = StyledPath(frame: .zero, path: Path.rectangle(rect))
//        let composite = Composite.leaf(.path(styledPath))
//        let resized = composite.resizedToFitContents
//
//        // Assert logic
//        XCTAssertEqual(resized.frame, rect)
//
//        // Check graphics
//        let before = CALayer(composite)
//        before.showTestBorder()
//        render(before, name: "testResizedToFitContentsLeafNoTranslation_before")
//
//        let after = CALayer(resized)
//        after.showTestBorder()
//        render(after, name: "testResizedToFitContentsLeafNoTranslation_after")
//    }
//
//    func testResizedToFitContentsLeafScaleAndTranslation() {
//
//        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
//        let path = Path.rectangle(x: 5, y: 5, width: 10, height: 10)
//        let styledPath = StyledPath(frame: frame, path: path)
//        let composite = Composite.leaf(.path(styledPath))
//        let resized = composite.resizedToFitContents
//
//        // Assert logic
//        let expected = Rectangle(x: 5, y: 5, width: 10, height: 10)
//        XCTAssertEqual(resized.frame, expected)
//
//        // Check graphics
//        let before = CALayer(composite)
//        before.showTestBorder()
//        render(before, name: "testResizedToFitContentsLeafScaleAndTranslation_before")
//
//        let after = CALayer(resized)
//        after.showTestBorder()
//        render(after, name: "testResizedToFitContentsLeafScaleAndTranslation_after")
//    }
//
//    func testResizedToFitContentsBranchScaleAndTranslation() {
//
//        let group = Group(frame: Rectangle(x: 5, y: 5, width: 100, height: 100))
//
//        // Offset by 0,0 in own coordinates
//        let a = Path.rectangle(x: 0, y: 0, width: 3, height: 3)
//
//        // Offset by 20,20 in parent coordinates
//        let styledA = StyledPath(frame: Rectangle(x: 20, y: 20, width: 4, height: 4), path: a)
//
//        // Offset by 5,5 in own coordinates
//        let b = Path.rectangle(x: 5, y: 5, width: 5, height: 5)
//
//        // Offset by 2,2 in parent coordinates
//        let styledB = StyledPath(frame: Rectangle(x: 2, y: 2, width: 10, height: 10), path: b)
//
//        let composite = Composite.branch(group, [.leaf(.path(styledA)), .leaf(.path(styledB))])
//        let resized = composite.resizedToFitContents
//
//        // Assert logic
//        let expected = Rectangle(x: 2, y: 2, width: 22, height: 22)
//        XCTAssertEqual(resized.frame, expected)
//
//        // Check graphics
//        let before = CALayer(composite)
//        before.showTestBorder()
//        render(before, name: "testResizedToFitContentsBranchScaleAndTranslation_before")
//
//        let after = CALayer(resized)
//        after.showTestBorder()
//        render(after, name: "testResizedToFitContentsBranchScaleAndTranslation_after")
//    }
//
//    func testResizedToFitContentsBranchScaleAndTranslation2() {
//
//        let group = Group(frame: Rectangle(x: 0, y: 0, width: 100, height: 100))
//
//        // Offset by 0,0 in own coordinates
//        let a = Path.rectangle(x: 0, y: 0, width: 3, height: 3)
//
//        // Offset by 0,0 in parent coordinates
//        let styledA = StyledPath(frame: Rectangle(x: 0, y: 0, width: 3, height: 3), path: a)
//
//        // Offset by 0,0 in own coordinates
//        let b = Path.rectangle(x: 0, y: 0, width: 10, height: 10)
//
//        // Offset by 20,20 in parent coordinates
//        let styledB = StyledPath(frame: Rectangle(x: 20, y: 20, width: 10, height: 10), path: b)
//
//        let composite = Composite.branch(group, [.leaf(.path(styledA)), .leaf(.path(styledB))])
//        let resized = composite.resizedToFitContents
//
//        // Assert logic
//        let expected = Rectangle(x: 0, y: 0, width: 30, height: 30)
//        XCTAssertEqual(resized.frame, expected)
//
//        // Check graphics
//        let before = CALayer(composite)
//        before.showTestBorder()
//        render(before, name: "testResizedToFitContentsBranchScaleAndTranslation2_before")
//
//        let after = CALayer(resized)
//        after.showTestBorder()
//        render(after, name: "testResizedToFitContentsBranchScaleAndTranslation2_after")
//    }
//}


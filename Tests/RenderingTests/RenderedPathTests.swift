//
//  StyledPathTests.swift
//  Rendering
//
//  Created by James Bean on 6/28/17.
//
//

import XCTest
import Geometry
import Path
import Rendering

// FIXME: Bring back in
//import GraphicsTestTools

//class StyledPathTests: GraphicsTestCase {
//
//    func testResizedToFitContents() {
//
//        let frame = Rectangle(x: 10, y: 10, width: 100, height: 100)
//        let path = Path.rectangle(x: 5, y: 5, width: 10, height: 10)
//        let renderedPath = StyledPath(frame: frame, path: path)
//        let resized = renderedPath.resizedToFitContents
//
//        // Assert logic
//        let expected = Rectangle(x: 15, y: 15, width: 10, height: 10)
//        XCTAssertEqual(resized.frame, expected)
//
//        // Check graphics
//        let before = CAShapeLayer(renderedPath)
//        before.showTestBorder()
//        render(before, name: "testResizedToFitContentsStyledPathScaleAndTranslation_before")
//
//        let after = CAShapeLayer(resized)
//        after.showTestBorder()
//        render(after, name: "testResizedToFitContentsStyledPathScaleAndTranslation_after")
//    }
//}


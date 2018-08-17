//
//  QuadraticBezierCurveTests.swift
//  Path
//
//  Created by James Bean on 6/8/17.
//
//

import XCTest
import Geometry
import Path
import Rendering
import GraphicsTesting

class QuadraticBezierCurveTests: XCTestCase {

    override func setUp() {
        createArtifactsDirectory(for: "\(type(of: self))")
    }

    override func tearDown() {
        openArtifactsDirectory()
    }
    
    // MARK: - Quadratic

    func testBezierCurveTsAtX() {

        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 0),
            control: Point(x: 0, y: 100),
            end: Point(x: 100, y: 100)
        )
        let dots = stride(from: 0.0, through: 100, by: 10).map { x -> StyledPath.Composite in

            let t = curve.ts(x: x).first ?? 0
            let y = curve[t].y

            // Add lines for each `y` value
            let linePath = Path.line(from: Point(x: x, y: 0), to: Point(x: x, y: 100))
            let styling = Styling(stroke: Stroke(width: 0.25, color: .lightGray))
            let styledLinePath = StyledPath(frame: frame, path: linePath, styling: styling)

            // Add dots at intersection
            let dotPath = Path.circle(center: Point(x: x, y: y), radius: 2)
            let styledDotPath = StyledPath(
                frame: frame,
                path: dotPath,
                styling: Styling(fill: Fill(color: .red))
            )

            return .branch(Group(), [
                .leaf(Item.path(styledLinePath)),
                .leaf(Item.path(styledDotPath))
            ])
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

    func testBezierCurveTsAtY() {

        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 0),
            control: Point(x: 0, y: 100),
            end: Point(x: 100, y: 100)
        )
        let dots = stride(from: 0.0, through: 100, by: 10).map { y -> StyledPath.Composite in

            let t = curve.ts(y: y).first ?? 0
            let x = curve[t].x

            // Add lines for each `y` value
            let linePath = Path.line(from: Point(x: 0, y: y), to: Point(x: 100, y: y))
            let styling = Styling(stroke: Stroke(width: 0.25, color: .lightGray))
            let styledLinePath = StyledPath(frame: frame, path: linePath, styling: styling)

            // Add dots at intersection
            let dotPath = Path.circle(center: Point(x: x, y: y), radius: 2)
            let styledDotPath = StyledPath(
                frame: frame,
                path: dotPath,
                styling: Styling(fill: Fill(color: .red))
            )

            return .branch(Group(), [
                .leaf(Item.path(styledLinePath)),
                .leaf(Item.path(styledDotPath))
            ])
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

    func testBezierCurveXsAtY() {
        let frame = Rectangle(x: 0, y: 0, width: 100, height: 100)
        let group = Group(frame: frame)
        let curve = BezierCurve(
            start: Point(x: 0, y: 0),
            control: Point(x: 25, y: 75),
            end: Point(x: 100, y: 100)
        )
        let dots = stride(from: 0.0, through: 100, by: 10).map { y -> StyledPath.Composite in
            let xs = curve.xs(y: y)
            print("y: \(y), xs: \(xs)")
            let x = xs.first ?? 0
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

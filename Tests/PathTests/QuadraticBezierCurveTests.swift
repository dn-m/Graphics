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
        let xs = stride(from: 0.0, through: 100, by: 10)
        let ts = xs.map { x in curve.ts(x: x) }
        let expected: [Set<Double>] = [
            [0.0],
            [0.31622776601683794],
            [0.447213595499958],
            [0.5477225575051662],
            [0.6324555320336759],
            [0.7071067811865476],
            [0.7745966692414834],
            [0.8366600265340756],
            [0.894427190999916],
            [0.9486832980505138],
            [1.0]
        ]
        XCTAssertEqual(ts, expected)

        let ys = ts.compactMap { $0.first }.map { t in curve[t].y }
        let dots = zip(xs,ys).map { x,y -> StyledPath.Composite in

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
        let ys = stride(from: 0.0, through: 100, by: 10)
        let ts = ys.map { y in curve.ts(y: y) }
        let expected: [Set<Double>] = [
            [-0.0],
            [0.05131670194948626],
            [0.10557280900008408],
            [0.1633399734659244],
            [0.22540333075851662],
            [0.2928932188134524],
            [0.3675444679663242],
            [0.45227744249483387],
            [0.552786404500042],
            [0.683772233983162],
            [1.0]
        ]
        XCTAssertEqual(ts, expected)

        let xs = ts.compactMap { $0.first }.map { t in curve[t].x }
        let dots = zip(xs,ys).map { x,y -> StyledPath.Composite in
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

        let xs = stride(from: 0.0, through: 100, by: 10)
        let ys = xs.map { x in curve.ys(x: x) }
        let expected: [Set<Double>] = [
            [0.0],
            [24.164078649987374],
            [41.24515496597099],
            [54.39088914585775],
            [64.93901531919198],
            [73.60679774997897],
            [80.8318915758459],
            [86.90465157330259],
            [92.02941017470886],
            [96.35642126552706],
            [100.0]
        ]
        XCTAssertEqual(ys, expected)

        let dots = zip(xs,ys.compactMap { $0.first }).map { x,y -> StyledPath.Composite in
            let xs = curve.xs(y: y)
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

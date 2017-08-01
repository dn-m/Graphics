//
//  PolygonTests.swift
//  PathTools
//
//  Created by James Bean on 6/5/17.
//
//

import XCTest
import Structure
import Math
@testable import Graphics

class PolygonTests: XCTestCase {

    // MARK: - Convexity

    func testConvexityFalse() {

        let polygon = Polygon(
            vertices: [
                Point(x: 10, y: 0),
                Point(x: 11, y: 20),
                Point(x: -3, y: 10),
                Point(x: -15, y: 20),
                Point(x: -15, y: 8)
            ]
        )

        XCTAssertFalse(polygon.isConvex)
    }

    func testSquareConvexityTrue() {
        let polygon = Polygon(Rectangle(x: 0, y: 0, width: 100, height: 100))
        XCTAssert(polygon.isConvex)
    }

    func testPentagonConvexityTrue() {

        let polygon = Polygon(
            vertices: [
                Point(x: 5, y: -5),
                Point(x: 10, y: 5),
                Point(x: 0, y: 10),
                Point(x: -10, y: 5),
                Point(x: -5, y: -5)
            ]
        )

        XCTAssert(polygon.isConvex)
    }

    // MARK: - Triangulation

    func testTriangleContainsPointTrue() {
        let triangle = Triangle(Point(x: 0, y: 0), Point(x: 10, y: 0), Point(x: 0, y: 10))
        let point = Point(x: 2.5, y: 2.5)
        XCTAssert(triangle.contains(point))
    }

    func testTriangleContainsPointFalse() {
        let triangle = Triangle(Point(x: 0, y: 0), Point(x: 10, y: 0), Point(x: 0, y: 10))
        let point = Point(x: 7.5, y: 7.5)
        XCTAssertFalse(triangle.contains(point))
    }

    func testPolygonOrderClockwise() {
        let polygon = Polygon(vertices: [(0,10),(10,0),(0,-10),(-10,0)].map(Point.init))
        XCTAssertEqual(polygon.rotation, .clockwise)
    }

    func testPolygonOrderCounterClockwise() {
        let polygon = Polygon(vertices: [(-10,0),(0,-10),(10,0),(0,10)].map(Point.init))
        XCTAssertEqual(polygon.rotation, .counterClockwise)
    }

    func testVertexConvexTrue() {
        // < = convex, when points arranged counterclockwise
        let triangle = Triangle(Point(x: 0, y: 10), Point(x: -10, y: 0), Point(x: 0, y: -10))
        XCTAssert(triangle.isConvex(rotation: .counterClockwise))
        XCTAssertFalse(triangle.isConvex(rotation: .clockwise))
    }

    func testVertexConvexFalse() {
        // > = concave, when points arranged counterclockwise
        let triangle = Triangle(Point(x: 0, y: 10), Point(x: 10, y: 0), Point(x: 0, y: -10))
        XCTAssertFalse(triangle.isConvex(rotation: .counterClockwise))
        XCTAssert(triangle.isConvex(rotation: .clockwise))
    }

    func testTriangleEqualToTriangulatedSelf() {
        let triangle = Polygon(
            vertices: [Point(x: 0, y: 10), Point(x: 0, y: 0), Point(x: 10, y: 0)]
        )
        let triangulated = triangle.triangulated
        let expected = [Triangle(Point(x: 10, y: 0), Point(x: 0, y: 10), Point(x: 0, y: 0))]
        XCTAssertEqual(triangulated, expected)
    }

    func testSquareTriangulated() {
        let square = Polygon(vertices: [(0,10),(0,0),(10,0),(10,10)].map(Point.init))
        let triangulated = square.triangulated
        let expected = [
            Triangle(Point(x: 10, y: 10), Point(x: 0, y: 10), Point(x: 0, y: 0)),
            Triangle(Point(x: 10, y: 10), Point(x: 0, y: 0), Point(x: 10, y: 0))
        ]
        XCTAssertEqual(triangulated, expected)
    }

    func testHouseTriangulated() {
        let house = Polygon(vertices: [(0,15),(-5,10),(-5,0),(5,0),(5,10)].map(Point.init))
        let triangulated = house.triangulated
        let expected = [
            Triangle(vertices: [(5,10),(0,15),(-5,10)].map(Point.init)),
            Triangle(vertices: [(5,10),(-5,10),(-5,0)].map(Point.init)),
            Triangle(vertices: [(5,10),(-5,0),(5,0)].map(Point.init))
        ]
        XCTAssertEqual(triangulated, expected)
    }

    func testBlockCTriangulated() {
        let points = [(2,3),(0,3),(0,0),(2,0),(2,1),(1,1),(1,2),(2,2)].map(Point.init)
        let blockC = Polygon(vertices: points)
        let triangulated = blockC.triangulated
        XCTAssertEqual(triangulated.count, 6)
        // FIXME: Add assertion!
    }

    func testBlockCTriangulatedClockwise() {

        let points = [(2,3),(0,3),(0,0),(2,0),(2,1),(1,1),(1,2),(2,2)]
            .reversed()
            .map(Point.init)

        let blockC = Polygon(vertices: points)
        let triangulated = blockC.triangulated
        XCTAssertEqual(triangulated.count, 6)
        // FIXME: Add assertion!
    }

    func testSum() {
        let a = Polygon(vertices: [(0,0),(2,0),(2,2),(0,2)].map(Point.init))
        let b = Polygon(vertices: [(3,3),(5,3),(5,5),(3,5)].map(Point.init))
        let expected = Polygon(vertices: [(0,0),(2,0),(5,3),(5,5),(3,5),(0,2)].map(Point.init))
        XCTAssertEqual(a + b, expected)
    }

    func testReduce() {

        let a = Polygon(vertices: [(0,0),(2,0),(2,2),(0,2)].map(Point.init))
        let b = Polygon(vertices: [(3,3),(5,3),(5,5),(3,5)].map(Point.init))
        let c = Polygon(vertices: [(0,6),(0,7),(-2,7),(-2,6)].map(Point.init))

        let expected = Polygon(
            vertices: [(-2,6),(0,0),(2,0),(5,3),(5,5),(0,7),(-2,7)].map(Point.init)
        )

        XCTAssertEqual(a + b + c, expected)
        XCTAssertEqual([a,b,c].sum, expected)
    }
}

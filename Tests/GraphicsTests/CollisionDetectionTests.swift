//
//  CollisionDetectionTests.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import XCTest
import Graphics

class CollisionDetectionTests: XCTestCase {

    func testEqualRectsIntersectingTrue() {

        let a = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let b = Rectangle(origin: Point(), size: Size(width: 100, height: 100))

        XCTAssert(collision(a,b))
    }

    func testRectsSeparatedAboveIntersectingFalse() {

        let a = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let b = Rectangle(origin: Point(x: 0, y: -101), size: Size(width: 100, height: 100))

        XCTAssertFalse(collision(a,b))
    }

    func testRectangleDiamondSeparatedIntersectingFalse() {

        let a = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let b = Polygon(vertices: [(150,200),(225,150),(150,75), (75,150)].map(Point.init))

        XCTAssertFalse(collision(a,b))
    }

    func testContainsPointInRectTrue() {

        let rect = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let point = Point(x: 50, y: 50)

        XCTAssert(rect.contains(point))
    }

    func testContainsPointInRectFalse() {

        let rect = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let point = Point(x: -1, y: 0)

        XCTAssertFalse(rect.contains(point))
    }

    func testYsAtXRect() {

        let rect = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let expected: Set<Double> = [0,100]

        XCTAssertEqual(expected, rect.ys(at: 25))
    }

    func testXsAtYRect() {

        let rect = Rectangle(origin: Point(), size: Size(width: 100, height: 100))
        let expected: Set<Double> = [0,100]

        XCTAssertEqual(expected, rect.xs(at: 75))
    }

    func testPolygonContainsPointTrue() {
        let points = [(2,3),(0,3),(0,0),(2,0),(2,1),(1,1),(1,2),(2,2)].map(Point.init)
        let blockC = Polygon(vertices: points)
        XCTAssert(blockC.contains(Point(x: 0.5, y: 2.5)))
    }

    func testPolygonContainsPointFalse() {
        let points = [(2,3),(0,3),(0,0),(2,0),(2,1),(1,1),(1,2),(2,2)].map(Point.init)
        let blockC = Polygon(vertices: points)
        XCTAssertFalse(blockC.contains(Point(x: 0, y: 2)))
    }

    func testConvexHull() {

        let points = [
            (1.5,0.5),
            (1.5,1.5),
            (1,2),
            (0.5,1.5),
            (0.5,0.5),
            (1,0),
            (2,0),
            (2,1),
            (2,2),
            (0,2),
            (0,1),
            (0,0)
        ].map(Point.init)

        let vertices = VertexCollection(points)
        let hull = vertices.convexHull
        let expected = VertexCollection([(0,0),(2,0),(2,2),(0,2)].map(Point.init))

        XCTAssertEqual(hull.count, expected.count)
        zip(hull, expected).forEach { a,b in XCTAssertEqual(a,b) }
    }
}

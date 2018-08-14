import XCTest

import GeometryTests
import RenderingTests
import PathTests

var tests = [XCTestCaseEntry]()
tests += GeometryTests.__allTests()
tests += RenderingTests.__allTests()
tests += PathTests.__allTests()

XCTMain(tests)

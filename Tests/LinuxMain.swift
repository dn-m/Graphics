import XCTest

import GeometryTests
import PathTests
import RenderingTests

var tests = [XCTestCaseEntry]()
tests += GeometryTests.__allTests()
tests += PathTests.__allTests()
tests += RenderingTests.__allTests()

XCTMain(tests)

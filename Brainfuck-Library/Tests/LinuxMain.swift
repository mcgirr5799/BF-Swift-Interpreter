import XCTest

import BrainFuckTests

var tests = [XCTestCaseEntry]()
tests += BrainfuckTests.allTests()
XCTMain(tests)

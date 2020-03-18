import XCTest

var tests = [XCTestCaseEntry]()
tests += DateValueDecodingTests.allTests()
tests += DateValueEncodingTests.allTests()
XCTMain(tests)

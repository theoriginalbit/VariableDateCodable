import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DateValueDecodingTests.allTests),
        testCase(DateValueEncodingTests.allTests),
    ]
}
#endif

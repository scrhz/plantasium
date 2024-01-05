import XCTest

struct TestUtils {
    static let oneDay = 60 * 60 * 24
    static let oneWeek = 7 * oneDay
}

class TestCase: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
}

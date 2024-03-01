import XCTest

struct TestUtils {
    static let oneDay = 60 * 60 * 24
    static let oneWeek = 7 * oneDay

    static func assertDatesAreEqual(date1: Date, date2: Date, granularity: Calendar.Component = .minute) {
        XCTAssertEqual(
            Calendar.current.compare(
                date1,
                to: date2,
                toGranularity: granularity
            ),
            ComparisonResult.orderedSame
        )
    }
}

class TestCase: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
}

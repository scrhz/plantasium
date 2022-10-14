import XCTest
import SwiftUI
@testable import Plantasium

final class ModelTests: XCTestCase {
    static let oneDay = 60 * 60 * 24
    static let oneWeek = 7 * oneDay

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testModelDataInitialisesCorrectly() {
        var testPlant = Plant(
            name: "foo",
            feedPeriod: TimeInterval(ModelTests.oneWeek)
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertNil(testPlant.lastFeed)
        XCTAssertEqual(testPlant.feedPeriod, TimeInterval(ModelTests.oneWeek))
        XCTAssertEqual(Calendar.current.compare(testPlant.nextFeed, to: Date.now, toGranularity: .minute), ComparisonResult.orderedSame)

        let validImage = Image(systemName: "trash")
        testPlant = Plant(
            name: "foo",
            species: "bar",
            feedPeriod: TimeInterval(ModelTests.oneWeek),
            image: validImage,
            lastFeed: Date(timeIntervalSince1970: 0)
        )

        XCTAssertEqual(Calendar.current.compare(testPlant.nextFeed, to: Date(timeIntervalSince1970: TimeInterval(ModelTests.oneWeek)), toGranularity: .minute), ComparisonResult.orderedSame)
        XCTAssertNotNil(testPlant.image)
    }
}

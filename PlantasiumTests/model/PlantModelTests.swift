import XCTest
import SwiftUI
@testable import Plantasium

final class PlantModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testPlantModelInitialisesCorrectlyForEssentialParameters() {
        let testPlant = Plant(
            name: "foo",
            feedPeriod: TimeInterval(TestUtils.oneWeek)
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertEqual(testPlant.feedPeriod, TimeInterval(TestUtils.oneWeek))
        XCTAssertEqual(
            Calendar.current.compare(testPlant.nextFeed, to: Date.now, toGranularity: .minute),
            ComparisonResult.orderedSame
        )
        XCTAssertNil(testPlant.species)
        XCTAssertNotNil(testPlant.image)
    }

    func testPlantModelInitialisesCorrectlyForExtraParameters() {
        let testPlant = Plant(
            name: "foo",
            feedPeriod: TimeInterval(TestUtils.oneWeek),
            species: "bar",
            lastFeed: Date(timeIntervalSinceNow: TimeInterval(-(2 * TestUtils.oneWeek))),
            imageName: "doesntExist"
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertEqual(testPlant.feedPeriod, TimeInterval(TestUtils.oneWeek))
        XCTAssertEqual(
            Calendar.current.compare(
                testPlant.nextFeed,
                to: Date(timeInterval: TimeInterval(-TestUtils.oneWeek), since: Date.now),
                toGranularity: .minute
            ),
            ComparisonResult.orderedSame
        )
        XCTAssertEqual(testPlant.species, "bar")
        XCTAssertNotNil(testPlant.image)
    }
}

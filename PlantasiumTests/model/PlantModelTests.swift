import XCTest
import SwiftUI
@testable import Plantasium

final class PlantTests: TestCase {
    func testPlantInitialisesCorrectlyForEssentialParameters() {
        let testPlant = Plant(
            name: "foo"
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertEqual(testPlant.feedPeriod.rawValue, 7)
        XCTAssertEqual(
            Calendar.current.compare(testPlant.nextFeed, to: Date.now, toGranularity: .minute),
            ComparisonResult.orderedSame
        )
        XCTAssertNotNil(testPlant.image)
    }

    func testPlantInitialisesCorrectlyForExtraParameters() {
        let testPlant = Plant(
            name: "foo",
            feedPeriod: .tenDays,
            lastFeed: Date(timeIntervalSinceNow: TimeInterval(-(2 * TestUtils.oneWeek)))
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertEqual(testPlant.feedPeriod.rawValue, 10)
        XCTAssertEqual(
            Calendar.current.compare(
                testPlant.nextFeed,
                to: Date(timeInterval: TimeInterval(-4 * TestUtils.oneDay), since: Date.now),
                toGranularity: .minute
            ),
            ComparisonResult.orderedSame
        )
        XCTAssertNotNil(testPlant.image)
    }
}

final class PlantModelTests: TestCase {
    func testPlantModelDefaultsToFile() { XCTFail() }

    func testPlantModelDeletesOnlySelectedPlant() { XCTFail() }

    func testPlantModelSavesCorrectly() { XCTFail() }
}

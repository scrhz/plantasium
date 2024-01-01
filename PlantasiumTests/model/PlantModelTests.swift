import XCTest
import SwiftUI
@testable import Plantasium

final class PlantTests: TestCase {
    func testPlantInitialisesCorrectlyForEssentialParameters() {
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
//        XCTAssertNil(testPlant.species)
        XCTAssertNotNil(testPlant.image)
    }

    func testPlantInitialisesCorrectlyForExtraParameters() {
        let testPlant = Plant(
            name: "foo",
            feedPeriod: TimeInterval(TestUtils.oneWeek),
//            species: "bar",
            lastFeed: Date(timeIntervalSinceNow: TimeInterval(-(2 * TestUtils.oneWeek)))
//            imageName: "doesntExist"
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
//        XCTAssertEqual(testPlant.species, "bar")
        XCTAssertNotNil(testPlant.image)
    }
}

final class PlantModelTests: TestCase {
    func testPlantModelDefaultsToFile() { XCTFail() }

    func testPlantModelDeletesOnlySelectedPlant() { XCTFail() }

    func testPlantModelSavesCorrectly() { XCTFail() }
}

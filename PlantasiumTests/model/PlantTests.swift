import XCTest
@testable import Plantasium

final class PlantTests: TestCase {
    func testPlantInitialisesCorrectlyForEssentialParameters() {
        let testPlant = Plant(
            name: "foo"
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertEqual(testPlant.feedPeriod.rawValue, 7)
        TestUtils.assertDatesAreEqual(date1: testPlant.nextFeed, date2: Date.now)
        XCTAssertNotNil(testPlant.image)
        XCTAssertNil(testPlant.lastFeed)
    }

    func testPlantInitialisesCorrectlyForExtraParameters() {
        let testPlant = Plant(
            name: "foo",
            feedPeriod: .tenDays,
            lastFeed: Date(timeIntervalSinceNow: TimeInterval(-(2 * TestUtils.oneWeek)))
        )

        XCTAssertEqual(testPlant.name, "foo")
        XCTAssertEqual(testPlant.feedPeriod.rawValue, 10)
        TestUtils.assertDatesAreEqual(
            date1: testPlant.nextFeed,
            date2: Date(timeIntervalSinceNow: TimeInterval(-4 * TestUtils.oneDay))
        )
        XCTAssertNotNil(testPlant.image)
    }

    func testFeedingPlantUpdatesLastFeed() {
        let weeklyPlant = Plant(name: "foo", feedPeriod: .oneWeek)
        let tenDayPlant = Plant(name: "foo", feedPeriod: .tenDays)

        weeklyPlant.feed()
        tenDayPlant.feed()

        TestUtils.assertDatesAreEqual(date1: weeklyPlant.lastFeed!, date2: Date.now)
        TestUtils.assertDatesAreEqual(date1: tenDayPlant.lastFeed!, date2: Date.now)
        TestUtils.assertDatesAreEqual(
            date1: weeklyPlant.nextFeed,
            date2: Date(timeIntervalSinceNow: TimeInterval(7 * TestUtils.oneDay))
        )
        TestUtils.assertDatesAreEqual(
            date1: tenDayPlant.nextFeed,
            date2: Date(timeIntervalSinceNow: TimeInterval(10 * TestUtils.oneDay))
        )
    }
}

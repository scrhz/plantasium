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
    override func setUp() {
        super.setUp()
        try? FileManager().removeItem(at: ModelUtils.filePath("plantData.json"))
    }

    func testPlantModelCreatesStubPlantsIfMissing() {
        let model = PlantModel()

        XCTAssertEqual(model.plants.count, 3)
        XCTAssertEqual(model.plants, ModelUtils.stubPlants)
    }

    func testPlantModelDefaultsToFileIfPresent() {
        let testPlants = [
            Plant(name: "A plant"),
            Plant(name: "Another plant")
        ]

        ModelUtils.save(testPlants, fileName: "plantData.json")

        let model = PlantModel()

        XCTAssertEqual(model.plants.count, 2)
        XCTAssertEqual(model.plants, testPlants)
    }

    func testPlantModelDeletesOnlySelectedPlant() {
        let plantToDelete = Plant(name: "deleting")
        let anotherPlant = Plant(name: "to keep")
        let testPlants = [plantToDelete, anotherPlant]

        ModelUtils.save(testPlants, fileName: "plantData.json")

        let model = PlantModel()

        model.delete(plantToDelete)

        XCTAssertEqual(model.plants.count, 1)
        XCTAssertFalse(model.plants.contains(plantToDelete))
    }

    func testPlantModelSavesCorrectly() {
        let model = PlantModel()
        let newPlant = Plant(name: "new plant")
        model.plants.append(newPlant)
        model.save()

        let loadedPlants: [Plant] = ModelUtils.load("plantData.json")

        XCTAssertEqual(loadedPlants.count, 4)
        XCTAssertTrue(loadedPlants.contains(newPlant))
    }
}

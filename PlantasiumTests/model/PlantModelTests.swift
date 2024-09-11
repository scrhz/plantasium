import XCTest
@testable import Plantasium

final class NotificationCentreStub: NotificationManaging {
    var scheduledNotificationData: [Plant: Bool] = [:]
    func scheduleNotification(for plant: Plant) async throws {
        scheduledNotificationData[plant] = true
    }
}

final class PlantModelTests: TestCase {
    var model: PlantModel!

    override func setUp() {
        super.setUp()
        try? FileManager().removeItem(at: ModelUtils.filePath("plantData.json"))
    }

    func createPlantModel() {
        model = PlantModel()
    }

    func testPlantModelCreatesStubPlantsIfMissing() {
        createPlantModel()

        XCTAssertEqual(model.plants.count, 3)
        XCTAssertEqual(model.plants, ModelUtils.stubPlants)
    }

    func testPlantModelDefaultsToFileIfPresent() {
        let testPlants = [
            Plant(name: "A plant"),
            Plant(name: "Another plant")
        ]

        ModelUtils.save(testPlants, fileName: "plantData.json")

        createPlantModel()

        XCTAssertEqual(model.plants.count, 2)
        XCTAssertEqual(model.plants, testPlants)
    }

    func testPlantModelDeletesOnlySelectedPlant() {
        let plantToDelete = Plant(name: "deleting")
        let anotherPlant = Plant(name: "to keep")
        let testPlants = [plantToDelete, anotherPlant]

        ModelUtils.save(testPlants, fileName: "plantData.json")

        createPlantModel()

        model.delete(plantToDelete)

        XCTAssertEqual(model.plants.count, 1)
        XCTAssertFalse(model.plants.contains(plantToDelete))
    }

    func testPlantModelSavesCorrectly() {
        createPlantModel()
        let newPlant = Plant(name: "new plant")
        model.plants.append(newPlant)
        model.save()

        let loadedPlants: [Plant] = ModelUtils.load("plantData.json")

        XCTAssertEqual(loadedPlants.count, 4)
        XCTAssertTrue(loadedPlants.contains(newPlant))
    }
}

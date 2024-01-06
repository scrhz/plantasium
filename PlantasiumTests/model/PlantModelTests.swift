import XCTest
@testable import Plantasium

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

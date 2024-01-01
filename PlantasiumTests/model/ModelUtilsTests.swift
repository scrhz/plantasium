import XCTest
import SwiftUI
@testable import Plantasium

final class ModelDataTests: TestCase {
    let testDataJson = "testData.json"

    override func tearDown() {
        let fileManager = FileManager()
        do {
            try fileManager.removeItem(at: ModelUtils.filePath(testDataJson))
        } catch {
            print(error)
        }
    }

    func testSavesMixedOptionalityPlantsInCorrectFormat() {
        let plantEssential = Plant(name: "foo", feedPeriod: TimeInterval())
        let plantAll = Plant(
            name: "bar",
            feedPeriod: TimeInterval(64000),
            lastFeed: Date(timeIntervalSince1970: TimeInterval(TestUtils.oneWeek * 100))
//            species: "lorem",
//            imageName: "ipsum"
        )

        let plants = [plantEssential, plantAll]

        ModelUtils.save(plants, fileName: testDataJson)

        let loadedPlants: [Plant] = ModelUtils.load(testDataJson)

        XCTAssertNotNil(loadedPlants)
        XCTAssertEqual(loadedPlants.count, 2)
        XCTAssertEqual(plants, loadedPlants)
    }
}

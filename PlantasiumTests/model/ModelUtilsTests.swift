import XCTest
import SwiftUI
@testable import Plantasium

final class ModelDataTests: XCTestCase {
    let testDataJson = "testData.json"

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

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
            species: "lorem",
            lastFeed: Date(timeIntervalSince1970: TimeInterval(TestUtils.oneWeek * 100)),
            imageName: "ipsum"
        )

        let plants = [plantEssential, plantAll]

        ModelUtils.save(plants, fileName: testDataJson)

        let newPlants: [Plant] = ModelUtils.load(testDataJson)

        XCTAssertNotNil(newPlants)
        XCTAssertEqual(newPlants.count, 2)
    }
}

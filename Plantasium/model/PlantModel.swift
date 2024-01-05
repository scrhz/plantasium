import Foundation
import SwiftUI

class PlantModel: ObservableObject {
    @Published var plants: [Plant] = []

    private var modelExists: Bool {
        FileManager().fileExists(atPath: ModelUtils.filePath(ModelUtils.jsonFileName).path())
    }

    init() {
        if !modelExists {
            plants = ModelUtils.stubPlants
            save()
        }

        load()
    }

    func save() {
        ModelUtils.save(plants, fileName: ModelUtils.jsonFileName)
    }

    func delete(_ plant: Plant) {
        guard let deletionIndex = plants.firstIndex(of: plant) else {
            fatalError("Couldn't find plant \(plant.id)")
        }
        plants.remove(at: deletionIndex)
    }

    private func load() {
        plants = ModelUtils.load(ModelUtils.jsonFileName)
    }
}

import Foundation
import SwiftUI

class PlantModel: ObservableObject {
    @Published var plants: [Plant] = []

    init() {
        if !FileManager().fileExists(atPath: ModelUtils.filePath(ModelUtils.jsonFileName).path()) {
//            let oneDay = 60 * 60 * 24
//            let oneWeek = 7 * oneDay
            plants = [
                Plant(name: "John"), //, feedPeriod: TimeInterval(oneWeek)),
                Plant(name: "Mary"), //, feedPeriod: TimeInterval(2 * oneWeek)),
                Plant(name: "Abdul"), //, feedPeriod: TimeInterval(0.5 * Double(oneWeek)))
            ]
            save()
        }

        load()
    }

    func save() {
        ModelUtils.save(plants, fileName: ModelUtils.jsonFileName)
    }

    func load() {
        plants = ModelUtils.load(ModelUtils.jsonFileName)
    }

    func delete(_ plant: Plant) {
        guard let deletionIndex = plants.firstIndex(of: plant) else {
            fatalError("Couldn't find plant \(plant.id)")
        }
        plants.remove(at: deletionIndex)
    }
}

class Plant: Hashable, Codable, Identifiable, ObservableObject {
    var id: UUID
    @Published var name: String
//    var feedPeriod: TimeInterval
//    var species: String?
//    var lastFeed: Date?
//    private var imageName: String?

    var image: Image {
//        Image(imageName ?? "plant-placeholder")
        Image("plant-placeholder")
    }

//    var nextFeed: Date {
//        guard let lastFeed = lastFeed else { return Date.now }
//        return Date(timeInterval: feedPeriod, since: lastFeed)
//    }

    init(
        name: String
//        feedPeriod: TimeInterval,
//        species: String? = nil,
//        lastFeed: Date? = nil,
//        imageName: String? = nil
    ) {
        self.id = UUID()
        self.name = name
//        self.species = species
//        self.imageName = imageName
//        self.feedPeriod = feedPeriod
//        self.lastFeed = lastFeed
    }

    enum CodingKeys: CodingKey {
        case id
        case name
    }

    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(name, forKey: .name)
        try values.encode(id, forKey: .id)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        try name = values.decode(String.self, forKey: .name)
        try id = values.decode(UUID.self, forKey: .id)
    }

    static func == (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
}

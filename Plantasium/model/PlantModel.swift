import Foundation
import SwiftUI

class PlantModel: ObservableObject {
    @Published var plants: [Plant] = []

    private var modelExists: Bool {
        FileManager().fileExists(atPath: ModelUtils.filePath(ModelUtils.jsonFileName).path())
    }

    init() {
        if !modelExists {
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

class Plant: Hashable, Codable, Identifiable, ObservableObject {
    var id: UUID
    @Published var name: String
    var feedPeriod: TimeInterval
    var lastFeed: Date?
//    var species: String?
//    private var imageName: String?

    var image: Image {
//        Image(imageName ?? "plant-placeholder")
        Image("plant-placeholder")
    }

    var nextFeed: Date {
        guard let lastFeed = lastFeed else { return Date.now }
        return Date(timeInterval: feedPeriod, since: lastFeed)
    }

    init(
        name: String,
        feedPeriod: TimeInterval = TimeInterval(Utils.oneWeek),
        lastFeed: Date? = nil
//        species: String? = nil,
//        imageName: String? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.feedPeriod = feedPeriod
        self.lastFeed = lastFeed
        //        self.species = species
        //        self.imageName = imageName
    }

    enum CodingKeys: CodingKey {
        case id
        case name
        case feedPeriod
        case lastFeed
    }

    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(name, forKey: .name)
        try values.encode(id, forKey: .id)
        try values.encode(feedPeriod, forKey: .feedPeriod)
        try values.encode(lastFeed, forKey: .lastFeed)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        try name = values.decode(String.self, forKey: .name)
        try id = values.decode(UUID.self, forKey: .id)
        try feedPeriod = values.decode(TimeInterval.self, forKey: .feedPeriod)
        try? lastFeed = values.decode(Date.self, forKey: .lastFeed)
    }

    static func == (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
        hasher.combine(feedPeriod)
        hasher.combine(lastFeed)
    }
}

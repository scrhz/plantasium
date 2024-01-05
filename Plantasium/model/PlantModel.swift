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

class Plant: Hashable, Codable, Identifiable, ObservableObject {
    var id: UUID
    @Published var name: String
    @Published var feedPeriod: FeedPeriod
    var lastFeed: Date?

    var image: Image {
        Image("plant-placeholder")
    }

    var nextFeed: Date {
        guard let lastFeed = lastFeed else { return Date.now }
        return Date(timeInterval: TimeInterval(feedPeriod.rawValue * Utils.oneDay), since: lastFeed)
    }

    init(
        name: String,
        feedPeriod: FeedPeriod = .oneWeek,
        lastFeed: Date? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.feedPeriod = feedPeriod
        self.lastFeed = lastFeed
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
        try values.encode(feedPeriod.rawValue, forKey: .feedPeriod)
        try values.encode(lastFeed, forKey: .lastFeed)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        try name = values.decode(String.self, forKey: .name)
        try id = values.decode(UUID.self, forKey: .id)
        try feedPeriod = FeedPeriod(rawValue: values.decode(Int.self, forKey: .feedPeriod)) ?? .oneWeek
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

extension Plant {
    enum FeedPeriod: Int, CaseIterable, Identifiable {
        var id: Self { self }

        case oneWeek = 7
        case tenDays = 10
        case fortnight = 14

        var label: String {
            switch self {
            case .oneWeek:
                return "One Week"
            case .tenDays:
                return "Ten Days"
            case .fortnight:
                return "One Fortnight"
            }
        }
    }
}
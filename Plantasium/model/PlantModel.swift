import Foundation
import SwiftUI

class PlantModel: ObservableObject {
    @Published var plants: [Plant]

    init() {
        self.plants = stubPlants
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

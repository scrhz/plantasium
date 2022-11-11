import Foundation
import SwiftUI

struct Plant: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var feedPeriod: TimeInterval
    var species: String?
    var lastFeed: Date?
    private var imageName: String?

    var image: Image {
        Image(imageName ?? "plant-placeholder")
    }

    var nextFeed: Date {
        guard let lastFeed = lastFeed else { return Date.now }
        return Date(timeInterval: feedPeriod, since: lastFeed)
    }

    init(
        name: String,
        feedPeriod: TimeInterval,
        species: String? = nil,
        lastFeed: Date? = nil,
        imageName: String? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.species = species
        self.imageName = imageName
        self.feedPeriod = feedPeriod
        self.lastFeed = lastFeed
    }
}

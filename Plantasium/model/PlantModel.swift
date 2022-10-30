import Foundation
import SwiftUI

struct Plant: Hashable, Codable {
    var name: String
    var species: String?
    var feedPeriod: TimeInterval
    var lastFeed: TimeInterval?
    private var imageName: String?

    var image: Image {
        Image(imageName ?? "plant-placeholder")
    }

    var nextFeed: Date {
        guard let lastFeed = lastFeed else { return Date.now }
        return Date(timeIntervalSince1970: lastFeed).addingTimeInterval(feedPeriod)
    }

    init(
        name: String,
        species: String? = nil,
        feedPeriod: TimeInterval,
        imageName: String? = nil,
        lastFeed: TimeInterval? = nil
    ) {
        self.name = name
        self.species = species
        self.imageName = imageName
        self.feedPeriod = feedPeriod
        self.lastFeed = lastFeed
    }
}

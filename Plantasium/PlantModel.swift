import Foundation
import SwiftUI

protocol Plantable {
    var name: String { get set }
    var species: String? { get set }
    var image: Image? { get set }
    var feedPeriod: TimeInterval { get }
    var lastFeed: Date? { get }
    var nextFeed: Date { get }
}

class Plant: Plantable {
    var name: String
    var species: String?
    var image: Image?
    var feedPeriod: TimeInterval
    var lastFeed: Date?

    var nextFeed: Date {
        guard let lastFeed = lastFeed else { return Date.now }
        return lastFeed.addingTimeInterval(feedPeriod)
    }

    init(
        name: String,
        species: String? = nil,
        feedPeriod: TimeInterval,
        image: Image? = nil,
        lastFeed: Date? = nil
    ) {
        self.name = name
        self.species = species
        self.image = image
        self.feedPeriod = feedPeriod
        self.lastFeed = lastFeed
    }
}

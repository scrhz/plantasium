import Foundation

let jsonFileName = "plantData.json"

var plants: Plant {
    let oneDay = 60 * 60 * 24
    let oneWeek = 7 * oneDay
    let stubPlant = Plant(name: "John", feedPeriod: TimeInterval(oneWeek))
    save(stubPlant)
    return load(jsonFileName)
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    let file = filePath(filename)

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from file directory:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func save(_ plant: Plant) {
    let jsonString = """
        {
            "name": "\(plant.name)",
            "species": "\(plant.species ?? "")",
            "feedPeriod": \(plant.feedPeriod),
            "lastFeed": \(plant.lastFeed ?? Date.now.timeIntervalSince1970),
        }
        """

    let pathWithFilename = filePath(jsonFileName)

    do {
        try jsonString.write(to: pathWithFilename,
                             atomically: true,
                             encoding: .utf8)
    } catch {
        fatalError("Couldn't save to \(pathWithFilename):\n\(error)")
    }
}

func filePath(_ name: String) -> URL {
    guard let documentDirectory = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
    ).first else {
        fatalError("Couldn't access document directory.")
    }

    return documentDirectory.appendingPathComponent(name)
}

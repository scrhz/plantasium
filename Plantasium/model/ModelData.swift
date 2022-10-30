import Foundation

let jsonFileName = "plantData.json"

var stubPlants: [Plant] {
    let oneDay = 60 * 60 * 24
    let oneWeek = 7 * oneDay
    let plants = [
        Plant(name: "John", feedPeriod: TimeInterval(oneWeek)),
        Plant(name: "Mary", feedPeriod: TimeInterval(2 * oneWeek)),
        Plant(name: "Abdul", feedPeriod: TimeInterval(0.5 * Double(oneWeek)))
    ]
    save(plants)
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

func save(_ plants: [Plant]) {
    let data: Data

    do {
        let encoder = JSONEncoder()
        try data = encoder.encode(plants)
    } catch {
        fatalError("Couldn't encode:\n\(plants)")
    }

    let pathWithFilename = filePath(jsonFileName)

    do {
        try data.write(to: pathWithFilename)
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

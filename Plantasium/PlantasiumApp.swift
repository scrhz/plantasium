import SwiftUI

@main
struct PlantasiumApp: App {
    @StateObject var plantModel = PlantModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView(plantModel: plantModel)
            }
            .navigationTitle("Plants")
        }.onChange(of: scenePhase) { phase in
            if phase == .inactive { plantModel.save() }
        }
    }
}

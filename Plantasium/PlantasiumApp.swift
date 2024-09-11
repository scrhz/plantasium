import SwiftUI

@main
struct PlantasiumApp: App {
    @StateObject var plantModel = PlantModel()
    @StateObject var notificationCentre = NotificationCentre()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView(plantModel: plantModel, notificationCentre: notificationCentre)
            }
            .navigationTitle("Plants")
            .task {
                try? await notificationCentre.requestAuthorisation()
            }
        }.onChange(of: scenePhase) { phase in
            if phase == .inactive { plantModel.save() }
        }
    }
}

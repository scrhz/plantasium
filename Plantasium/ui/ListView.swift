import Foundation
import SwiftUI

struct ListView: View {
    @ObservedObject var plantModel: PlantModel
    var notificationCentre: NotificationCentre

    var body: some View {
        List(plantModel.plants) { plant in
            NavigationLink {
                PlantDetailEditView(plant: plant)
            } label: {
                RowView(plant: plant)
            }.swipeActions(edge: .trailing) {
                Button(
                    action: { plantModel.delete(plant) },
                    label: { Label("Delete", systemImage: "trash") }
                ).tint(.red)
            }.swipeActions(edge: .leading) {
                Button(
                    action: {
                        plant.feed()
                    },
                    label: { Label("Feed", systemImage: "drop") }
                )
                .tint(.green)
                .task {
                    try? await notificationCentre.scheduleNotification(for: plant)
                }
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    PlantDetailNewView(plantModel: plantModel)
                } label: {
                    Label("Add new plant", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    FAQListView()
                } label: {
                    Label("Get help", systemImage: "questionmark")
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(plantModel: PlantModel(), notificationCentre: NotificationCentre())
    }
}

import Foundation
import SwiftUI

struct ListView: View {
    @ObservedObject var plantModel: PlantModel

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
                    action: { plant.feed() },
                    label: { Label("Feed", systemImage: "drop") }
                ).tint(.green)
            }
        }.toolbar {
            NavigationLink {
                PlantDetailNewView(plantModel: plantModel)
            } label: {
                Label("Add new plant", systemImage: "plus")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(plantModel: PlantModel())
    }
}

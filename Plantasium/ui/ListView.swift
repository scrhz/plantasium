import Foundation
import SwiftUI

struct ListView: View {
    @StateObject var plantModel = PlantModel()

    var body: some View {
        List(plantModel.plants) { plant in
            NavigationLink {
                PlantDetailView(plant: plant)
            } label: {
                RowView(plant: plant)
            }.swipeActions {
                Button(action: { plantModel.delete(plant) }, label: { Label("Delete", systemImage: "trash") }).tint(.red)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

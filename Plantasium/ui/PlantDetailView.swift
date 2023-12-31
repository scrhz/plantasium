import SwiftUI

struct PlantDetailView: View {
    @State var plant: Plant

    var body: some View {
        Form {
            Section(header: Text("Plant Details")) {
                TextField("Name", text: $plant.name)
                //species etc
            }
            Section(header: Text("Feeding")) {
                //Time picker for
            }
        }.navigationTitle("Edit Plant")
    }
}

struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetailView(plant: PlantModel().plants[0])
    }
}

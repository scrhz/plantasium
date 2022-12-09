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
        }
    }
}

struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetailView(plant: stubPlants[0])
    }
}

import SwiftUI

struct PlantDetailView: View {
    @ObservedObject var plant: Plant

    var body: some View {
        Form {
            Section(header: Text("Plant Details")) {
                TextField("Name", text: $plant.name)
            }
            Section(header: Text("Feeding")) {
                Picker("Feed Period", selection: $plant.feedPeriod) {
                    ForEach(Plant.FeedPeriod.allCases) { feedPeriod in
                        Text(feedPeriod.label).tag(feedPeriod)
                    }
                }
            }
        }
    }
}

struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetailView(plant: PlantModel().plants[0])
    }
}

struct PlantDetailEditView: View {
    @State var plant: Plant

    var body: some View {
        PlantDetailView(plant: plant).navigationTitle("Edit Plant")
    }
}

struct PlantDetailNewView: View {
    @StateObject var plant = Plant(name: "")
    @StateObject var plantModel: PlantModel

    var body: some View {
        PlantDetailView(plant: plant).toolbar {
            Button {
                plantModel.plants.append(plant)
            } label: {
                Text("Save")
            }.disabled(plant.name.isEmpty)
        }.navigationTitle("New Plant")
    }
}

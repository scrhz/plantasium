import SwiftUI

struct PlantDetailView: View {
    @ObservedObject var plant: Plant
    @State private var showFileImporter = false

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
            Section(header: Text("Image")) {
                VStack(alignment: .center) {
                    plant.image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .padding()
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .fileImporter(
                        isPresented: $showFileImporter,
                        allowedContentTypes: [.image]
                    ) { result in
                        switch result {
                        case .success(let success):
                            break
                        case .failure(let failure):
                            break
                        }
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
    @ObservedObject var plant: Plant

    var body: some View {
        PlantDetailView(plant: plant).navigationTitle("Edit Plant")
    }
}

struct PlantDetailNewView: View {
    @StateObject var plant = Plant(name: "")
    @ObservedObject var plantModel: PlantModel

    @Environment(\.dismiss) var dismiss
    @State var showAlert = false

    var body: some View {
        PlantDetailView(plant: plant).toolbar {
            Button {
                if plantModel.plants.contains(where: { existingPlant in
                    existingPlant.name == plant.name
                }) {
                    showAlert = true
                } else {
                    plantModel.plants.append(plant)
                    dismiss()
                }
            } label: {
                Text("Save")
            }
            .disabled(plant.name.isEmpty)
            .alert("Name duplication", isPresented: $showAlert) {
                Button("Ok", role: .cancel) {}
            }
        }.navigationTitle("New Plant")
    }
}

import Foundation
import SwiftUI

struct RowView: View {
    @StateObject var plant: Plant

    var body: some View {
        HStack {
            plant.image
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(plant.name)
                    .bold()
//                Text(plant.species ?? "Unknown species")
//                    .italic()
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Next feed:")
//                Text(plant.nextFeed.formatted())
//                    .fontWeight(.light)
//                    .dynamicTypeSize(.small)
            }.padding(10)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RowView(plant: PlantModel().plants[0])
        }.previewLayout(.sizeThatFits)
    }
}

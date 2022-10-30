import Foundation
import SwiftUI

struct RowView: View {
    var plant: Plant

    var body: some View {
        HStack {
            plant.image
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(plant.name)
                    .bold()
                Text(plant.species ?? "Unknown species")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Next feed:")
                Text(plant.nextFeed.formatted())
                    .fontWeight(.light)
            }.padding(10)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(plant: stubPlant)
    }
}

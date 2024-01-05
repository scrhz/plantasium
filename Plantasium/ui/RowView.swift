import Foundation
import SwiftUI

struct RowView: View {
    @ObservedObject var plant: Plant
    private var dateFormatStyle: Date.FormatStyle {
        Date.FormatStyle()
            .locale(Locale(identifier: "en-GB"))
            .day(.defaultDigits)
            .weekday(.abbreviated)
            .month(.abbreviated)
            .year(.twoDigits)
    }

    var body: some View {
        HStack {
            plant.image
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(plant.name)
                    .bold()
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Next feed:")
                Text(plant.nextFeed.formatted(dateFormatStyle))
                    .fontWeight(.light)
                    .dynamicTypeSize(.small)
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

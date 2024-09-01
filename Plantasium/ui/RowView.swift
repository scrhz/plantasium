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

    enum FeedPeriodMessage: String {
        case oneDay = "everyday"
        case oneWeek = "every week"
        case tenDays = "every 10 days"
        case fortnight = "once a fortnight"

        init(for feedPeriod: Plant.FeedPeriod) {
            switch feedPeriod {
            case .oneDay:
                self = .oneDay
            case .oneWeek:
                self = .oneWeek
            case .tenDays:
                self = .tenDays
            case .fortnight:
                self = .fortnight
            }
        }
    }

    var body: some View {
        HStack {
            plant.image
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(plant.name)
                    .bold()
                Text("Feed \(FeedPeriodMessage(for: plant.feedPeriod).rawValue)")
                    .fontWeight(.ultraLight)
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

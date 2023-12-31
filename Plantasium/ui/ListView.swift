import Foundation
import SwiftUI

struct ListView: View {
    var body: some View {
        List(PlantModel().plants) { plant in
            NavigationLink {
                PlantDetailView(plant: plant)
            } label: {
                RowView(plant: plant)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

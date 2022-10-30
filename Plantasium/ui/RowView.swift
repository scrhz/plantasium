import Foundation
import SwiftUI

struct RowView: View {
    var plant: Plant

    var body: some View {
        HStack {
            plant.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(plant.name)
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(plant: plants)
    }
}

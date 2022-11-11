import Foundation
import SwiftUI

struct ListView: View {
    var body: some View {
        List(stubPlants) {
            RowView(plant: $0)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

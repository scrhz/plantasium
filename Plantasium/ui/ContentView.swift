import SwiftUI

struct ContentView: View {
    var homeView: UITabBarController!
    
    var body: some View {
        NavigationView {
            ListView()
        }
        .navigationTitle("Plants")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct FAQListView: View {
    @State private var searchText = ""
    @State private var questionResults: [FAQ] = []

    var body: some View {
        List(questionResults) { faq in
            NavigationLink {
                FAQDetailView(faq: faq)
            } label: {
                Text(faq.question)
            }
        }
        .navigationTitle("Plant FAQs & Help")
        .task {
            do {
                questionResults = try await QuestionAPI().requestFAQs()
            } catch {
                print("Couldn't request FAQs")
            }
        }
    }
}

struct FAQListView_Previews: PreviewProvider {
    static var previews: some View {
        FAQListView()
    }
}

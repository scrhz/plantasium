import SwiftUI

struct FAQListView: View {
    @State private var searchText = ""
    @State private var questionResults: [FAQ] = []
    @State private var isLoading = false

    var body: some View {
        if isLoading {
            ProgressView()
        }

        List(questionResults) { faq in
            NavigationLink {
                FAQDetailView(faq: faq)
            } label: {
                Text(faq.question)
            }
        }
        .navigationTitle("Plant FAQs & Help")
        .task {
            await search()
        }
        .searchable(text: $searchText).onSubmit(of: .search) {
            Task {
                await search(term: searchText)
            }
        }
    }

    func search(term: String? = nil) async {
        do {
            isLoading = true
            questionResults = try await QuestionAPI().requestFAQs(searchTerm: term)
            isLoading = false
        } catch {
            print("Couldn't request FAQs")
        }
    }
}

struct FAQListView_Previews: PreviewProvider {
    static var previews: some View {
        FAQListView()
    }
}

import SwiftUI

struct FAQDetailView: View {
    var faq: FAQ

    var body: some View {
        ScrollView {
            VStack {
                if let imageString = faq.default_image?.medium_url,
                   let imageUrl = URL(string: imageString)
                {
                    Spacer()
                    AsyncImage(url: imageUrl) {
                        $0.resizable()
                    } placeholder: {
                        ProgressView()
                    }.aspectRatio(contentMode: .fill)
                }
                Spacer()
                Text(faq.question)
                Spacer()
                Text(faq.answer)
                Spacer()
            }.padding()
        }
    }
}

struct FAQDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FAQDetailView(faq: FAQ(
            id: 1,
            question: "What is your question?",
            answer: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            default_image: DefaultImage(original_url: nil, regular_url: nil, medium_url: "https://perenual.com/storage/article_faq/faq_22SBDw6435fb830145c/medium.jpg"))
        )
    }
}

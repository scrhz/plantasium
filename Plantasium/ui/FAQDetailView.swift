import SwiftUI

struct FAQDetailView: View {
    var faq: FAQ

    var body: some View {
        VStack {
            Spacer()
            Text(faq.question)
            Spacer()
            Text(faq.answer)
            Spacer()
        }.padding()
    }
}

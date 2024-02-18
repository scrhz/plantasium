import Foundation

struct DefaultImage: Codable {
    let original_url: String?
    let regular_url: String?
    let medium_url: String?
}

struct FAQ: Identifiable, Codable {
    let id: Int
    let question: String
    let answer: String
    let default_image: DefaultImage?
}

struct FAQResponse: Codable {
    var data: [FAQ]
}

enum APIError: Error {
    case invalidUrl
    case unexpectedResponse
    case jsonDecodeFailure
}

struct QuestionAPI {
    private let faqBaseUrl = URL(string: "https://perenual.com/api/article-faq-list")
    private let keyQuery = URLQueryItem(name: "key", value: ApiAuthSettings.apiKey)

    func requestFAQs(searchTerm: String? = nil) async throws -> [FAQ] {
        let searchQuery = URLQueryItem(name: "q", value: searchTerm)

        guard let url = faqBaseUrl?.appending(queryItems: [keyQuery, searchQuery])
        else {
            throw APIError.invalidUrl
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200
            else {
                throw APIError.unexpectedResponse
            }

            if let faqList = try? JSONDecoder().decode(FAQResponse.self, from: data) {
                return faqList.data
            } else {
                throw APIError.jsonDecodeFailure
            }
        } catch {
            print("HTTP Request Failed: \(error)")
        }
        
        return []
    }
}

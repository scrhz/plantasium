import XCTest
@testable import Plantasium

class QuestionAPITests: TestCase {
    func testQuestionApiReturnsValidFAQs() async {
        let faqs = try! await QuestionAPI().requestFAQs()
        XCTAssertNotNil(faqs)
        XCTAssertFalse(faqs.isEmpty)
    }

    func testSearchingEmptyStringReturnsValidFAQs() async {
        let faqs = try! await QuestionAPI().requestFAQs(searchTerm: "")
        XCTAssertNotNil(faqs)
        XCTAssertFalse(faqs.isEmpty)
    }
}

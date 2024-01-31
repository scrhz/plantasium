import XCTest
@testable import Plantasium

class QuestionAPITests: TestCase {
    func testQuestionApiReturnsValidFAQs() async {
        let faqs = try! await QuestionAPI().requestFAQs()
        XCTAssertNotNil(faqs)
        XCTAssertFalse(faqs.isEmpty)
    }
}

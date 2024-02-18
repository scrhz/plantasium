import XCTest
@testable import Plantasium

class NotificationCentreTests: TestCase {
    func testNotificationCentreInitialisesProperly() {
        let notificationCentre = NotificationCentre()

        XCTAssertNotNil(notificationCentre)
    }

    func testNotificationCentrePostsNotificationForGivenPlantTime() {
        let plant = Plant(name: "test plant", feedPeriod: .fortnight, lastFeed: Date.now)

        let notificationCentre = NotificationCentre()

        notificationCentre.scheduleNotification(for: plant)

        let plants: [Plant] = []

        XCTAssertEqual(notificationCentre.scheduledNotifications.count, 1)
        TestUtils.assertDatesAreEqual(
            date1: notificationCentre.scheduledNotifications.first.scheduledDate,
            date2: Date(timeIntervalSinceNow: TimeInterval(14 * TestUtils.oneDay))
        )
    }
}

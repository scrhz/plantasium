import XCTest
@testable import Plantasium

class NotificationCentreTests: TestCase {
    func testNotificationCentreInitialisesProperly() {
        let notificationCentre = NotificationCentre()

        XCTAssertNotNil(notificationCentre)
    }

    func testNotificationCentrePostsNotificationForGivenPlantTime() async {
        let plant = Plant(name: "test plant", feedPeriod: .fortnight, lastFeed: Date.now)

        let notificationCentre = NotificationCentre()

        try? await notificationCentre.scheduleNotification(for: plant)

        let plants: [Plant] = []

        let notificationTrigger = await UNUserNotificationCenter.current().pendingNotificationRequests().first?.trigger as? UNCalendarNotificationTrigger

        XCTAssertEqual(notificationCentre.scheduledNotifications!.count, 1)
        TestUtils.assertDatesAreEqual(
            date1: notificationTrigger!.nextTriggerDate()!,
            date2: Date(timeIntervalSinceNow: TimeInterval(14 * TestUtils.oneDay))
        )
    }
}

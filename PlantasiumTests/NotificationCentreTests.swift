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

        try! await notificationCentre.scheduleNotification(for: plant)

        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()

        let notificationTrigger = requests.first?.trigger as? UNCalendarNotificationTrigger
        
        XCTAssertNotNil(notificationTrigger?.dateComponents.day)
        XCTAssertNotNil(notificationTrigger?.dateComponents.month)
        XCTAssertNotNil(notificationTrigger?.dateComponents.year)
        XCTAssertNotNil(notificationTrigger?.dateComponents.isValidDate(in: Calendar.current))

        TestUtils.assertDatesAreEqual(
            date1: notificationTrigger!.nextTriggerDate()!,
            date2: Date(timeIntervalSinceNow: TimeInterval(14 * TestUtils.oneDay)),
            granularity: .day
        )
    }
}

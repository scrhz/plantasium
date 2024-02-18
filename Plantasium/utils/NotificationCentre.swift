import UserNotifications

struct NotificationCentre {
    var scheduledNotifications: [UNMutableNotificationContent]?

    func scheduleNotification(for plant: Plant) async throws {
        let notification = UNMutableNotificationContent()
        notification.title = "Time to water \(plant.name)!"
        notification.body = "Water \(plant.name) and update your Plantasium."

        let dateComponents = Calendar.current.dateComponents([.weekday], from: plant.nextFeed)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()

        do {
            try await notificationCenter.add(request)
        } catch {
            throw error
        }
    }
}

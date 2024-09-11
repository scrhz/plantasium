import UserNotifications

protocol NotificationManaging {
    func scheduleNotification(for plant: Plant) async throws
}

class NotificationCentre: ObservableObject, NotificationManaging {
    private let notificationCentre = UNUserNotificationCenter.current()

    func scheduleNotification(for plant: Plant) async throws {
        let notification = UNMutableNotificationContent()
        notification.title = "Time to water \(plant.name)!"
        notification.body = "Water \(plant.name) and update your Plantasium."

        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: plant.nextFeed)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)

        do {
            try await notificationCentre.add(request)
        } catch {
            fatalError("Couldn't schedule notification with error:\n \(error)")
        }
    }

    func requestAuthorisation() async throws {
        do {
            try await notificationCentre.requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            throw error
        }
    }
}

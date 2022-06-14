//
//  ReminderView.swift
//  Waterly
//
//  Created by James Emselle on 14/6/2022.
//

import UserNotifications

struct Reminder {
    func setReminder(at: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, _ in
            if success {
                let content = UNMutableNotificationContent()
                content.title = "Your plants are looking thirsty"
                content.subtitle = "You asked us to remind you last time you watered them"
                content.sound = UNNotificationSound.default
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: at), repeats: false)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            }
        })
    }
}

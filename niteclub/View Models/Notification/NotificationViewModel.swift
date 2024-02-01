//
//  NotificationViewModel.swift
//  niteclub
//
//  Created by +++ on 1/19/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var notificationsByDate = [String: [UserNotification]]()

    // Mock data - replace with your data source
    private var allNotifications = [UserNotification]()

    init() {
        loadNotifications()
    }

    func loadNotifications() {
        // TODO: Load your notifications from a data source

        // Grouping notifications by date
        for notification in allNotifications {
            let dateString = relativeDateString(for: notification.timestamp)
            notificationsByDate[dateString, default: []].append(notification)
        }
    }
    
    // Function to check if a notification is from today
    func isNotificationToday(_ notificationDate: Date) -> Bool {
        return relativeDateString(for: notificationDate) == "Today"
    }

    private func relativeDateString(for date: Date) -> String {
        // Logic to return a string like "Today", "Yesterday", etc.
        // Implement the logic based on your requirement
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            // Format and return the date for notifications older than yesterday
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
    }


    // Additional methods for handling user interactions, etc.
}

//
//  NotificationManager.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 15/12/24.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    
    // Singleton instance for global access
    static let shared = NotificationManager()
    
    // Private initializer to enforce Singleton pattern
    private init() {}
    
    
    // MARK: - Send Local Notification
    /// Sends a local notification with a title, body, and an optional date (format: "YYYY-MM-DD HH:mm:ss")
    func sendNotification(on viewController: UIViewController, title: String, body: String, customDate: String? = nil) {
        // Parse the custom date if provided, otherwise use the current date
        var notificationDate: Date
        if let dateString = customDate {
            notificationDate = convertStringToDate(dateString: dateString)
        } else {
            notificationDate = Date()
        }
        
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        // Calculate the trigger time
        let timeInterval = notificationDate.timeIntervalSinceNow
        if timeInterval <= 0 {
            print("Error: The date provided is in the past. Notification will be sent immediately.")
            AlertManager.showErrorAlert(on: viewController,
                                        title: "Notification Failed",
                                        message: "The date provided is in the past. Notification will be sent immediately.")
        }
        
        // Create a trigger for the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, timeInterval), repeats: false)
        
        // Create the notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Add the notification request to the system
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(notificationDate)")
            }
        }
    }
    
    // MARK: - Convert Custom Date String to Date
    /// Converts a date string in "YYYY-MM-DD HH:mm:ss" format to a Date object
    private func convertStringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            print("Error: Could not convert date string to Date. Using current date instead.")
            return Date() // Default to current date if conversion fails
        }
    }
  
    
}

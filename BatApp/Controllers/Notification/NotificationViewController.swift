//
//  NotificationViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 15/12/24.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var calendarDatePicker: UIDatePicker!
    
    @IBOutlet weak var notificationMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Notification"
    }
    
    @IBAction func addNotification(_ sender: UIButton) {
        // Get the selected date from the DatePicker
        let selectedDate = self.calendarDatePicker.date
        print("Nueva fecha seleccionada: \(selectedDate)")
        
        // Format the date to "YYYY-MM-DD HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Proper date format
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        // Get the custom message from the UITextField
        guard let message = notificationMessage.text, !message.isEmpty else {
            AlertManager.showErrorAlert(on: self,
                                        title: "Notification Failed",
                                        message: "The message cannot be empty.")
            return
        }
        
        print("Fecha formateada: \(formattedDate)")
        print("Notification message: \(message)")
        
        // Call NotificationManager to schedule the notification
        NotificationManager.shared.sendNotification(
            on: self,
            title: "🕒 Reminder - BatApp",
            body: message,
            customDate: formattedDate
        )
        
        print("Notification scheduled for \(formattedDate) with message: \(message)")
        
        // Optionally, clear the message field and reset the date picker
        notificationMessage.text = ""
    }
}

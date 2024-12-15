//
//  NotificationViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 15/12/24.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var calendarDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Notification"
    }
    
    @IBAction func addNotification(_ sender: UIButton) {
        let selectedDate = self.calendarDatePicker.date
        print("Nueva fecha seleccionada: \(selectedDate)")
        
        // Formatear la fecha para mostrarla
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        print("Fecha formateada: \(formattedDate)")
    }
}

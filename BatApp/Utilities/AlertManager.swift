//
//  AlertManager.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 15/12/24.
//

import UIKit

class AlertManager {
    
    /// Shows an alert
    static func showErrorAlert(on viewController: UIViewController,
                               title: String = "Error",
                               message: String,
                               acceptMessage: String = "OK",
                               completion: (() -> Void)? = nil) {
        
        // Create the alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add an OK action
        let okAction = UIAlertAction(title: acceptMessage, style: .default) { _ in
            if let completion = completion {
                completion() // Call the completion handler if it exists
            }
        }
        
        alertController.addAction(okAction)
        
        // Present the alert
        viewController.present(alertController, animated: true, completion: nil)
    }
}

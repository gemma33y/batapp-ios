//
//  AppDelegate.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/10/24.
//

import UIKit
import IQKeyboardManagerSwift
import CoreStore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.isEnabled = true
        
        do {
            try CoreStoreDefaults.dataStack.addStorageAndWait()
        } catch {
            print("Error initializing the database: \(error.localizedDescription)")
        }
                
        // Request permission to show notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print("Permission denied: \(error.localizedDescription)")
            }
        }
        
        scheduleLocalNotification()
        
        return true
    }
    
    func scheduleLocalNotification() {
        // 1. Create content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Hello, Swift Developer!"
        content.body = "This is your first local notification 🚀"
        content.sound = UNNotificationSound.default
        
        
        // 2. Create a trigger for the notification (fire in 10 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // 3. Create a request with a unique identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // 4. Add the request to the Notification Center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


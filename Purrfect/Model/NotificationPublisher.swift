
import Foundation
import UIKit
import UserNotifications



class NotificationPublisher: NSObject {
    
    // Function to send notification for feeding time
    func sendFeedingNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Reminder"
        notificationContent.subtitle = ""
        notificationContent.body = "It's time to feed your cats!"
        var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
        currentBadgeCount += 1
        notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        notificationContent.sound = UNNotificationSound.default
        UNUserNotificationCenter.current().delegate = self
        
        let date = HomeViewController.alarms.feedingTime
        
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let request = UNNotificationRequest(identifier: "TestLocalNotification", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Function to send notification for feeding time
    func sendPlayNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Reminder"
        notificationContent.subtitle = ""
        notificationContent.body = "It's time to play with your cats!"
        var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
        currentBadgeCount += 1
        notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        notificationContent.sound = UNNotificationSound.default
        UNUserNotificationCenter.current().delegate = self
        
        let date = HomeViewController.alarms.playTime
        
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let request = UNNotificationRequest(identifier: "TestLocalNotification", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Function to send notification for feeding time
    func sendLitterBoxNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Reminder"
        notificationContent.subtitle = ""
        notificationContent.body = "It's time to clean you cats' litterbox!"
        var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
        currentBadgeCount += 1
        notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        notificationContent.sound = UNNotificationSound.default
        UNUserNotificationCenter.current().delegate = self
        
        let date = HomeViewController.alarms.litterBoxTime
        
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let request = UNNotificationRequest(identifier: "TestLocalNotification", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension NotificationPublisher: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        
        switch identifier {
            
        case UNNotificationDismissActionIdentifier:
            completionHandler()
            
        case UNNotificationDefaultActionIdentifier:
            completionHandler()
            
        default:
            completionHandler()
        }
    }
}

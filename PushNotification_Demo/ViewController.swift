//
//  ViewController.swift
//  PushNotification_Demo
//
//  Created by Tushar on 27/12/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
    }

    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert,.sound]) { didallow, error in
                    if didallow{
                        self.sentNotification()
                    }
                }
            case .denied:
                return
            case .authorized:
                self.sentNotification()
            
            default:
                return
            }
        }
        
    }
    
    func sentNotification(){
        let identifire = "my-morning-notification"
        let title = "Time to workout"
        let body = "Donn't be lazy little butt!"
        let hour = 11
        let minute = 52
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content .sound = .default
        
        let calender = Calendar.current
        var dateComponent = DateComponents(calendar: calender,timeZone: TimeZone.current)
        dateComponent.hour = hour
        dateComponent.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifire])
        notificationCenter.add(request)
    }

}


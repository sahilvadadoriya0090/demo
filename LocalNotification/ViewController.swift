//
//  ViewController.swift
//  LocalNotification
//
//  Created by Sahil on 08/02/21.
//

import UIKit
import UserNotifications

class ViewController: UIViewController , UNUserNotificationCenterDelegate{

  //MARK : Outlets
  @IBOutlet weak var NotificationOutlet: UIButton!
  
  //MARK : Variable
  let notificationCenter = UNUserNotificationCenter.current()
  
  //MARK : Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    notificationCenter.delegate = self
    notificationCenter.requestAuthorization(options:[.alert, .badge, .sound]) { (success, error) in
    }
  }

  
  //MARK : Action Button
  @IBAction func BTNnotification(_ sender: Any) {
    
    //MARK : Content
    let content = UNMutableNotificationContent()
    content.categoryIdentifier = "My Notification"
    content.title = "Local Notification"
    content.body = "This is demo of Local notification"
    content.badge = 1
    content.sound = UNNotificationSound.default
    
    //MARK : Ontent Image
    let url = Bundle.main.url(forResource: "facebook", withExtension: "png")
    let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
    content.attachments = [attachment]
    
    //MARK : Trigger Time
    let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 2, repeats: false)
    let identifier = "Main Identifier"
    
    //MARK : Request
    let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
    
    //MARK : Add request to notification center  
    notificationCenter.add(request) { (error) in
      print("\(error?.localizedDescription)")
    }
    
    //MARK : Notification Action
    let like = UNNotificationAction.init(identifier: "Like", title: "Like", options: .foreground)
    let delete = UNNotificationAction.init(identifier: "Delete", title: "Delete", options: .destructive)
    let category = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [like, delete], intentIdentifiers: [], options: [])
    notificationCenter.setNotificationCategories(([category]))
  }
  
  //MARK : Delegate Method
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .badge, .sound])
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let notificationVC : NotificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
    self.navigationController?.pushViewController(notificationVC, animated: true)
  }
}


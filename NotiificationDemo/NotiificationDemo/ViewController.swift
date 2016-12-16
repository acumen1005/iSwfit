//
//  ViewController.swift
//  NotiificationDemo
//
//  Created by acumen on 16/12/13.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

  @IBOutlet weak var imageNotiButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onClick(_ sender: UIButton) {
    
    if #available(iOS 10.0, *) {
      let content = UNMutableNotificationContent()
      content.title = "iOS10 推送测试"
      content.body = "附件"
      content.userInfo = ["icon":"1","mutable-content":1]
      content.categoryIdentifier = "InputSomething"
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
      
      let requestIdentifier = "imageLocal"
      print(Bundle.main)
      if let imageURL = Bundle.main.url(forResource: "avatar@2x", withExtension: "png"), let attachment = try? UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil) {
        
        content.attachments = [attachment]
      }
      
      let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
      
      UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
        if (error != nil) {
          print("error: \(error.debugDescription)")
        }
      })
    }
  }
}


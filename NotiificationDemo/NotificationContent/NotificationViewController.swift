//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by acumen on 16/12/13.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
  @IBOutlet weak var iconView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
      self.label?.text = notification.request.content.body
      iconView.image = UIImage(named: "avatar@2x")
      iconView.contentMode = .scaleAspectFit
      print("has?~~~~")
    }
}

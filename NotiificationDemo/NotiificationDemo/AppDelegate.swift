//
//  AppDelegate.swift
//  UserNotificationDemo
//
//  Created by acumen on 16/12/9.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    resgisteNotificationCategory()
    registerNotification()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to then background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  private func resgisteNotificationCategory() {
    
    let inputCatrgory: UNNotificationCategory = {
      
      let inputAction = UNTextInputNotificationAction(
        identifier: InputCategoryAction.input.rawValue,
        title: "输入",
        options: [.foreground],
        textInputButtonTitle: "发送",
        textInputPlaceholder: "写点什么吧")
      
      let okAction = UNNotificationAction(
        identifier: InputCategoryAction.ok.rawValue,
        title: "好的",
        options: [.foreground])
      
      let cancelAction = UNNotificationAction(
        identifier: InputCategoryAction.cancel.rawValue,
        title: "取消",
        options: [.destructive])
      
      return UNNotificationCategory(identifier: UserNotificationCategoryType.InputSomething.rawValue, actions: [inputAction, okAction, cancelAction], intentIdentifiers: [], options: [])
    }()
    
    let myCatrgory: UNNotificationCategory = {
      
      let commentAction = UNTextInputNotificationAction(
        identifier: myNotificationAction.comment.rawValue,
        title: "写评论",
        options: [.foreground],
        textInputButtonTitle: "发送",
        textInputPlaceholder: "写点什么吧")
      
      let zanAction = UNNotificationAction(
        identifier: myNotificationAction.zan.rawValue,
        title: "点赞",
        options: [.authenticationRequired])
      
      let cancelAction = UNNotificationAction(
        identifier: myNotificationAction.cancel.rawValue,
        title: "取消",
        options: [.destructive])
      
      return UNNotificationCategory(identifier: UserNotificationCategoryType.myNotificationCategory.rawValue, actions: [commentAction, zanAction, cancelAction], intentIdentifiers: [], options: [])
    }()
    UNUserNotificationCenter.current().setNotificationCategories([inputCatrgory, myCatrgory])
  }

  // MARK: - notification
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = deviceToken.hexString
    print("GET token - \(token)")
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Registration failed!")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
    print(userInfo)
  }
}

enum UserNotificationCategoryType: String {
  case InputSomething
  case myNotificationCategory
}

enum myNotificationAction: String {
  case comment
  case cancel
  case zan
}

enum InputCategoryAction: String {
  case input
  case cancel
  case ok
}

extension Data {
  var hexString: String {
    return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
      let buffer = UnsafeBufferPointer(start: bytes, count: count)
      return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
    }
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  
  func registerNotification() {
    let application = UIApplication.shared
    if #available(iOS 10.0, *) {
      let notificationCenter = UNUserNotificationCenter.current()
      notificationCenter.delegate = self
      notificationCenter.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
        if (granted) {
          application.registerForRemoteNotifications()
        }
      })
    } else {
      application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge], categories: nil))
      application.registerForRemoteNotifications()
    }
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    if let category = UserNotificationCategoryType(rawValue: response.notification.request.content.categoryIdentifier) {
      switch category {
      case .InputSomething:
        handleInputSomething(response: response)
      case .myNotificationCategory:
        handleMyNotificationCategory(response: response)
      }
    }
    completionHandler()
  }
  
  private func handleInputSomething(response: UNNotificationResponse) {
    let text: String
    
    if let actionType = InputCategoryAction(rawValue: response.actionIdentifier) {
      switch actionType {
      case .input: text = (response as! UNTextInputNotificationResponse).userText
      case .ok: text = "好的"
      case .cancel: text = ""
      }
    } else {
      text = ""
    }
    
    if !text.isEmpty {
      print("repsone = \(text)")
    }
  }
    
    private func handleMyNotificationCategory(response: UNNotificationResponse) {
        let text: String
        
        if let actionType = myNotificationAction(rawValue: response.actionIdentifier) {
            switch actionType {
            case .comment: text = (response as! UNTextInputNotificationResponse).userText
            case .zan: text = "赞一下"
            case .cancel: text = ""
            }
        } else {
            text = ""
        }
        
        if !text.isEmpty {
            print("repsone = \(text)")
        }
        
    }
}



//
//  ViewController.swift
//  ExtensionDemo
//
//  Created by acumen on 16/12/25.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var netButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    let texts: [String] = ["搞个大新闻","闷声发大财"]
    let images: [String] = ["avatar","lufei"]
    var clickCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        shareLabel.numberOfLines = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickToDownload(_ sender: Any) {
        
        let str = "http://ww2.sinaimg.cn/thumbnail/934b5ef8gw1fapacnkgk6j20oz0oz420.jpg"
        let userDefault = UserDefaults(suiteName: "group.extension.demo")
        userDefault?.set(str, forKey: "com.acumen.url")
        userDefault?.synchronize()
    }
    
    @IBAction func onClickToChange(_ sender: Any) {
        
        clickCount = (clickCount + 1) % 2
        
        let userDefault = UserDefaults(suiteName: "group.extension.demo")
        userDefault?.set(texts[clickCount], forKey: "com.acumen.text")
        userDefault?.set("today test!", forKey: "com.acumen.icon")
        userDefault?.set(getData(imageName: images[clickCount]), forKey: "com.acumen.data")
        userDefault?.removeObject(forKey: "com.acumen.url")
        userDefault?.synchronize()
    }
    
    func  getData(imageName: String) -> Data {
        if let image = UIImage(named: imageName) {
            return UIImageJPEGRepresentation(image, 0.9)!
        } else {
            return Data()
        }
    }
    
    func applicationWillResignActive() {
        
        let userDefault = UserDefaults(suiteName: "group.extension.demo")
        let url = userDefault?.value(forKey: "com.acumen.share.url") as? String
        if let tmp = url {
            self.shareLabel.text = "分享链接: \(tmp)"
        }
    }
}


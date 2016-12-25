//
//  ViewController.swift
//  ExtensionDemo
//
//  Created by acumen on 16/12/25.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var netButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    let texts: [String] = ["搞个大新闻","闷声发大财"]
    let images: [String] = ["avatar","lufei"]
    var clickCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickToDownload(_ sender: Any) {
        
        let str = "http://ww2.sinaimg.cn/mw690/934b5ef8gw1fasejq1g84j20x807iwgp.jpg"
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
        self.save()
    }

    func save() {
        
    }
}


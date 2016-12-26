//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by acumen on 16/12/25.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit
import NotificationCenter
import ExtensionFramework

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let userDefault = UserDefaults(suiteName: "group.extension.demo")
        
        
        
        if let url = userDefault?.value(forKey: "com.acumen.url") as? String {
            hintLabel.text = "来自网络图片"
            download(url: URL(string: url)!, completionHandler: { str in
                
            })
        } else {
            let string = userDefault?.value(forKey: "com.acumen.text")
            hintLabel.text = string as! String?
            
            let data = userDefault?.value(forKey: "com.acumen.data")
            iconView.image = UIImage(data: data as! Data)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        extensionContext?.open(URL(string: "todayextension://test")!, completionHandler: nil)
    }
    
    private func download(url: URL, completionHandler: @escaping (_ localURL: String?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            data, res, error in
            
            self.iconView.image = UIImage(data: data!)
            
           completionHandler("")
        })
        
        task.resume()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}

extension FileManager {
    var cachesDirectory: String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}

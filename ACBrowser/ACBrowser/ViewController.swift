//
//  ViewController.swift
//  ACBrowser
//
//  Created by acumen on 16/12/20.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var openButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickToOpen(_ sender: Any) {
        
        let browser = ACBrowserViewController(url: URL(string: "https://www.baidu.com")!)
        self.present(browser, animated: true, completion: nil)
    }
}


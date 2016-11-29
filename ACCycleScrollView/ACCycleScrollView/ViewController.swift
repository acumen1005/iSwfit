//
//  ViewController.swift
//  ACCycleScrollView
//
//  Created by acumen on 16/11/28.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    var cycleScrollView: ACCycleScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageNames = ["banner1","banner2","banner3","banner1","banner2","banner3"]
        
        cycleScrollView = ACCycleScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH/5.0 * 2.0), images: imageNames as NSArray, timeInterval: 3.0)
        
        self.view.addSubview(cycleScrollView!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


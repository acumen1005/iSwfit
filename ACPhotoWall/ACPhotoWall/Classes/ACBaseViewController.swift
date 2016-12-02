//
//  ACBaseViewController.swift
//  ACSearchViewController
//
//  Created by acumen on 16/12/1.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ACBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backButton = UIBarButtonItem(image: UIImage(named: "NavigationBack"), style: .plain, target: self, action: #selector(onClick2Back))
        
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - 
    
    func onClick2Back() {
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

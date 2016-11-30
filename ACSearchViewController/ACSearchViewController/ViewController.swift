//
//  ViewController.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    var searchBar: ACSearchBar?
    var backButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        searchBar = ACSearchBar(frame: CGRect.zero)
        searchBar?.barStyle = .default
        searchBar?.delegate = self
        searchBar?.searchBarStyle = .minimal
        
        backButton = UIBarButtonItem(image: UIImage(named: "icon_book_mark"), style: .plain, target: self, action: #selector(onClick2Back))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("search button")
        
        pushSearchController()
        
        return false
    }
    
    
    func onClick2Back() {
    
    }
    
    // MARK: - 
    
    func pushSearchController() {
    
        let searchController: ACSearchViewController = ACSearchViewController()
        
        self.navigationController?.pushViewController(searchController, animated: true)
    }

}


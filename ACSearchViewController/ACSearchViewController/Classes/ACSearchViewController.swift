//
//  ACSearchViewController.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let CELL_IDENTIFIER: String = "UITableViewCell"
let TITLE_CELL_IDENTIFIER: String = "ACSearchTitleCell"
let CONTENT_CELL_IDENTIFIER: String = "ACSearchContentCell"

class ACSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var searchBar: ACSearchBar?
    var backButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    var tableView: UITableView?
    var historyView: ACHistoryView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        
        searchBar = ACSearchBar(frame: CGRect.zero)
        searchBar?.barStyle = .default
        searchBar?.delegate = self
        searchBar?.searchBarStyle = .minimal
        
        let hx = self.view.bounds.origin.x
        let hy = self.view.bounds.origin.y + 64
        historyView = ACHistoryView(frame: CGRect(x: hx, y: hy, width: SCREEN_WIDTH, height: 3 * CELL_HISTORY_HEIGHT))
        
        backButton = UIBarButtonItem(image: UIImage(named: "NavigationBack"), style: .plain, target: self, action: #selector(onClick2Back))
        
        cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onClick2Cancel))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = searchBar
        
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CELL_IDENTIFIER)
        tableView?.register(UINib(nibName: TITLE_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: TITLE_CELL_IDENTIFIER)
        
        tableView?.register(UINib(nibName: CONTENT_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CONTENT_CELL_IDENTIFIER)
        
        self.view.addSubview(tableView!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK -
    
    func onClick2Cancel() {
        
        self.navigationItem.rightBarButtonItem = nil
        searchBar?.endEditing(true)
        dismissHistoryView()
    }
    
    func onClick2Back() {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // mark - 
    
    func routeCellWithIndexPath(withIndexPath: IndexPath) -> UITableViewCell {
        
        if(withIndexPath.row == 0){
            return (tableView?.dequeueReusableCell(withIdentifier: TITLE_CELL_IDENTIFIER, for: withIndexPath))!
        }
        else {
            return (tableView?.dequeueReusableCell(withIdentifier: CONTENT_CELL_IDENTIFIER, for: withIndexPath))!
        }
    }
    
    func presentHistoryView() {
        self.view.addSubview(historyView!)
        self.tableView?.removeFromSuperview()
    }
    
    func dismissHistoryView() {
        historyView?.removeFromSuperview()
        self.view.addSubview(self.tableView!)
    }
    
    // MARK -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = routeCellWithIndexPath(withIndexPath: indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 40
        }
        else {
            return 100
        }
    }
    
    // MARK: - 
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = cancelButton
        presentHistoryView()
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

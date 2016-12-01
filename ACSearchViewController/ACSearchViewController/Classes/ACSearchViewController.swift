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

class ACSearchViewController: ACBaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var searchBar: UISearchBar?
    var cancelButton: UIBarButtonItem?
    var tableView: UITableView?
    var historyView: ACHistoryView?
    var hotSearchs: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configSubViews()
        configNavigtionBar()
        
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CELL_IDENTIFIER)
        tableView?.register(UINib(nibName: TITLE_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: TITLE_CELL_IDENTIFIER)
        
        tableView?.register(UINib(nibName: CONTENT_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CONTENT_CELL_IDENTIFIER)
        
        self.hotSearchs = ["杭州","北京","上海","深圳","广州","宁波","温州"]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        searchBar?.endEditing(true)
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
    
    // MARK: -  private methods
    
    private func configSubViews() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        
        searchBar = UISearchBar(frame: CGRect.zero)
        searchBar?.barStyle = .default
        searchBar?.delegate = self
        searchBar?.searchBarStyle = .minimal
        
        let hx = self.view.bounds.origin.x
        let hy = self.view.bounds.origin.y + 64
        historyView = ACHistoryView(frame: CGRect(x: hx, y: hy, width: SCREEN_WIDTH, height: CGFloat(HISTORY_COUNT) * CELL_HISTORY_HEIGHT))
        historyView?.pushSearchViewResultControllerClosure = {(string: String) -> Void in
            
            self.pushResultContolleAndDismissHistoryView(string: string)
        }
        
        self.navigationItem.titleView = searchBar
        self.view.addSubview(tableView!)
    }
    
    private func configNavigtionBar() {
        cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onClick2Cancel))
    }
    
    private func routeCellWithIndexPath(withIndexPath: IndexPath) -> UITableViewCell {
        
        if(withIndexPath.row == 0){
            return (tableView?.dequeueReusableCell(withIdentifier: TITLE_CELL_IDENTIFIER, for: withIndexPath))!
        }
        else {
            return (tableView?.dequeueReusableCell(withIdentifier: CONTENT_CELL_IDENTIFIER, for: withIndexPath))!
        }
    }
    
    private func renderSearchContentCell(_ cell: UITableViewCell) -> ACSearchContentCell {
        
        return cell as! ACSearchContentCell
    }
    
    private func presentHistoryView() {
        self.view.addSubview(historyView!)
        self.tableView?.removeFromSuperview()
    }
    
    private func dismissHistoryView() {
        historyView?.removeFromSuperview()
        self.view.addSubview(self.tableView!)
    }
    
    private func pushResultContolleAndDismissHistoryView(string: String) {
        
        dismissHistoryView()
        self.searchBar?.endEditing(true)
        
        //加入history
        addHistorySearchItem(string: string)
        
        let title = "搜索: \(string)"
        let vc: ACSearchResultController = ACSearchResultController()
        vc.title = title
        _ = self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addHistorySearchItem(string: String) {
        historyView?.addHistoryArray(string: string)
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = routeCellWithIndexPath(withIndexPath: indexPath)
        
        if 0 == indexPath.row {
        
        }
        else {
            renderSearchContentCell(cell).setHotSearchs(array: self.hotSearchs)
            renderSearchContentCell(cell).pushSearchViewResultControllerClosure = {(string: String) -> Void in
                
                self.pushResultContolleAndDismissHistoryView(string: string)
            }
        }
        
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
    
    // MARK: -  UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = cancelButton
        presentHistoryView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pushResultContolleAndDismissHistoryView(string: searchBar.text!)
        
        // code store to backend request
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

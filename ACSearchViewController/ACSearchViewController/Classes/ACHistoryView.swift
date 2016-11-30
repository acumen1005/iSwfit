//
//  ACHistoryView.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let CELL_HISTORY_IDENTIFIER: String = "ACHistoryCell"

class ACHistoryView: UIView, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    var height: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.green
        height = 3 * CELL_HISTORY_HEIGHT
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height!))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isScrollEnabled = false
        tableView?.separatorStyle = .none
        tableView?.register(UINib(nibName: CELL_HISTORY_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_HISTORY_IDENTIFIER)
        
        self.addSubview(tableView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.frame = (tableView?.frame)!
    }
    
    // MARK - 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_HISTORY_IDENTIFIER, for: indexPath) as! ACHistoryCell
        
        if indexPath.row == 2 {
            cell.sethistoryLabel(string: "清除历史纪录")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CELL_HISTORY_HEIGHT
    }

}

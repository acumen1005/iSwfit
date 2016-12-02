//
//  ACHistoryView.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let CELL_HISTORY_IDENTIFIER: String = "ACHistoryCell"

protocol ACHistoryViewDelegate: NSObjectProtocol{
    func pushSearchViewResultController(string: String) -> Void;
}

class ACHistoryView: UIView {

    var tableView: UITableView?
    var height: CGFloat?
    var array: [String] = []
    var fileManager: FileManager?
    weak var delgate: ACHistoryViewDelegate?
    var pushSearchViewResultControllerClosure: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.green
        height = CGFloat(HISTORY_COUNT) * CELL_HISTORY_HEIGHT
        
        fileManager = FileManager.default
        self.array = readHistoryFromDisk() as! [String]
        
        configSubViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: -  private methods
    
    private func configSubViews() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height!))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.register(UINib(nibName: CELL_HISTORY_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_HISTORY_IDENTIFIER)
        
        self.addSubview(tableView!)
    }
    
    // MARK: - public methods
    
    public func addHistoryArray(string: String) {
        
        if isExitsForString(string: string) {
            return 
        }
        self.array.removeAll()
        self.array.append(string)
        let strings = readHistoryFromDisk() as! [String]
        
        var index: Int = 0
        for str in strings {
            if(index < HISTORY_COUNT_MAX){
                self.array.append(str)
            }
            else {
                break
            }
            index = index + 1
        }
        
        storeHistory2Disk(self.array as NSArray)
        
        self.tableView?.reloadData()
    }
    
    func isExitsForString(string: String) -> Bool {
        
        if (fileManager?.fileExists(atPath: CACHE_HISTORY_PATH))! {
            let strings = readHistoryFromDisk() as! [String]
            return strings.contains(string)
        }
        else {
            return false
        }
    }
    
    func storeHistory2Disk(_ array: NSArray) {
        
        if (fileManager?.fileExists(atPath: CACHE_HISTORY_PATH))! {
            array.write(toFile: CACHE_HISTORY_PATH, atomically: true)
        }
        else {
            fileManager?.createFile(atPath: CACHE_HISTORY_PATH, contents: Data(), attributes: [:])
            array.write(toFile: CACHE_HISTORY_PATH, atomically: true)
        }
    }
    
    func readHistoryFromDisk() -> NSArray{
        
        if (fileManager?.fileExists(atPath: CACHE_HISTORY_PATH))! {
            return NSArray(contentsOfFile: CACHE_HISTORY_PATH)!
        }
        else {
            return NSArray()
        }
    }
    
    func cleanHistoryFromDisk() -> Void {
        
        if (fileManager?.fileExists(atPath: CACHE_HISTORY_PATH))! {
            do {
                try fileManager?.removeItem(atPath: CACHE_HISTORY_PATH)
            } catch _ {
                
            }
        }
    }
    
}

extension ACHistoryView: UITableViewDataSource {
    
    // MARK: - UITabaleViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(array.count > 0){
            return array.count + 1
        }
        else {
            return array.count
        }
    }
}

extension ACHistoryView: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_HISTORY_IDENTIFIER, for: indexPath) as! ACHistoryCell
        
        if indexPath.row == array.count {
            cell.sethistoryLabel(string: "清除历史纪录")
        }
        else {
            cell.sethistoryLabel(string: array[indexPath.row] as NSString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CELL_HISTORY_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if array.count == indexPath.row {
            array.removeAll()
            cleanHistoryFromDisk()
            
            tableView.reloadData()
        }
        else {
            if (self.pushSearchViewResultControllerClosure != nil) {
                self.pushSearchViewResultControllerClosure!(array[indexPath.row])
            }
        }
    }
}

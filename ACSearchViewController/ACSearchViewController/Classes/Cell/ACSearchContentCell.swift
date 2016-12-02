//
//  ACSearchContentCell.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let CELL_COLLECTION_IDENTIFIER: String = "ACHotSearchCell"

class ACSearchContentCell: UITableViewCell {

//    var collectionView: UICollectionView?
    var hotSearchs: NSArray = NSArray()
    var collectionView: UICollectionView?
    var pushSearchViewResultControllerClosure: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let count = CELL_COUNT
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(PT10, SPACING, 0, SPACING)
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - SPACING * CGFloat(count + 1))/CGFloat(count), height: 30)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200), collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = self.backgroundColor
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(UINib(nibName: CELL_COLLECTION_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: CELL_COLLECTION_IDENTIFIER)
        
        self.addSubview(collectionView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK - 
    
    func setHotSearchs(array: NSArray) {
        self.hotSearchs = array
        self.collectionView?.reloadData()
    }
}

extension ACSearchContentCell: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.hotSearchs.count
    }
}

extension ACSearchContentCell: UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_COLLECTION_IDENTIFIER, for: indexPath);
        
        (cell as! ACHotSearchCell).setContentLabel(string: self.hotSearchs[indexPath.row] as! String)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (self.pushSearchViewResultControllerClosure != nil) {
            self.pushSearchViewResultControllerClosure!(self.hotSearchs[indexPath.row] as! String)
        }
    }
}

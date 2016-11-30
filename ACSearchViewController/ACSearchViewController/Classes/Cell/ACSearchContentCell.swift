//
//  ACSearchContentCell.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let CELL_COLLECTION_IDENTIFIER: String = "ACHotSearchCell"

class ACSearchContentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

//    var collectionView: UICollectionView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let count = CELL_COUNT
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(PT10, SPACING, 0, SPACING)
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - SPACING * CGFloat(count + 1))/CGFloat(count), height: 30)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = self.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CELL_COLLECTION_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: CELL_COLLECTION_IDENTIFIER)
        
        self.addSubview(collectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_COLLECTION_IDENTIFIER, for: indexPath);
        
        return cell;
    }
    
}

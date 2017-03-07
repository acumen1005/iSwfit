//
//  ACCollectionViewLayout.swift
//  ACWaterfallLayout
//
//  Created by acumen on 17/3/3.
//  Copyright © 2017年 acumen. All rights reserved.
//

import UIKit

class ACCollectionViewLayout: UICollectionViewLayout {
    
    var numberOfItem: Int
    var numberOfSection: Int
    open var numberOfRow: Int
    
    open var itemSpacing: CGFloat
    var contentSize: CGSize
    
    var columnHeights: [CGFloat]
    var updateHeights: [[CGFloat]]
    var attributes: [UICollectionViewLayoutAttributes]
    
    open var delegate: ACCollectionViewLayoutDelegate? = nil
    
    override init() {
        numberOfSection = 1
        numberOfItem = 0
        numberOfRow = 2
        itemSpacing = 5
        contentSize = CGSize.zero
        columnHeights = []
        attributes = []
        updateHeights = []
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[indexPath.item]
    }
    
    override func prepare() {
        super.prepare()
        var loop = 0
        // initilize
        numberOfSection = collectionView!.numberOfSections
        numberOfItem = collectionView!.numberOfItems(inSection: 0)
        updateHeights = Array(repeating: Array(repeating: 0, count: numberOfRow), count: 2)
        attributes = Array(repeating: UICollectionViewLayoutAttributes(), count: numberOfItem)
        
        var maxheight: CGFloat = 0
        for row in 0 ..< numberOfItem {
            let modRow = row % numberOfRow
            let indexPath = IndexPath(row: row, section: 0)
            let itemSize = self.delegate?.sizeForItem(collectionView!, layout: self, indexPath: indexPath)
            let newSize = self.renderScale(itemSize: itemSize!)
            var xOffset: CGFloat = 0
            var tmp: CGFloat = 0
            
            if modRow > 0 {
                xOffset = (newSize.width + itemSpacing) * CGFloat(modRow)
            }
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: xOffset, y: updateHeights[loop][modRow], width: newSize.width, height: newSize.height)
            self.attributes[row] = attribute
            
            tmp = updateHeights[loop][modRow] + newSize.height + itemSpacing
            updateHeights[(loop + 1) % 2][modRow] = tmp
            maxheight = max(tmp - itemSpacing, CGFloat(maxheight))
            
            if modRow == 0 {
                loop = (loop + 1) % 2
            }
        }
        
        contentSize = CGSize(width: collectionView!.frame.width, height: maxheight)
    }
}

extension ACCollectionViewLayout {
    func renderScale(itemSize originSize: CGSize) -> CGSize {
        let itemWidth = ((collectionView?.frame.width)! - CGFloat(numberOfRow - 1) * itemSpacing)
            / CGFloat(numberOfRow)
        let scale = itemWidth / originSize.width
        return CGSize(width: itemWidth, height: scale * originSize.height)
    }
}

protocol ACCollectionViewLayoutDelegate {
    func sizeForItem(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize;
}

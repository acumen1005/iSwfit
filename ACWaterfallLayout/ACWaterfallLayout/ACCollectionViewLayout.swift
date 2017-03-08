//
//  ACCollectionViewLayout.swift
//  ACWaterfallLayout
//
//  Created by acumen on 17/3/3.
//  Copyright © 2017年 acumen. All rights reserved.
//

import UIKit

class ACCollectionViewLayout: UICollectionViewLayout {
    
    static let ACCollectionViewSectionHeader = "ACCollectionViewSectionHeader"
    static let ACCollectionViewSectionFooter = "ACCollectionViewSectionFooter"
    
    var numberOfItem: Int
    var numberOfSection: Int
    open var numberOfRow: Int
    open var sectionHeaderHeight: CGFloat
    open var sectionFooterHeight: CGFloat
    
    open var interitemSpacing: CGFloat
    open var lineSpacing: CGFloat
    var contentSize: CGSize
    
    var columnHeights: [CGFloat]
    var updateHeights: [[CGFloat]]
    var attributes: [UICollectionViewLayoutAttributes]
    
    open var delegate: ACCollectionViewLayoutDelegate? = nil
    
    override init() {
        sectionHeaderHeight = 0
        sectionFooterHeight = 0
        numberOfSection = 1
        numberOfItem = 0
        numberOfRow = 2
        interitemSpacing = 5
        lineSpacing = 5
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
        
        let headerAtttibute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ACCollectionViewLayout.ACCollectionViewSectionHeader, with: IndexPath(item: 0, section: 0))
        headerAtttibute.frame = CGRect(x: 0, y: 0, width: Layout.SCREEN_WIDTH!, height: sectionHeaderHeight)
        attributes.append(headerAtttibute)
        updateHeights[0] = Array(repeating: sectionHeaderHeight + interitemSpacing, count: numberOfRow);
        
        var maxheight: CGFloat = 0
        for row in 0 ..< numberOfItem {
            let modRow = row % numberOfRow
            let indexPath = IndexPath(row: row, section: 0)
            let itemSize = self.delegate?.sizeForItem(collectionView!, layout: self, indexPath: indexPath)
            let newSize = self.renderScale(itemSize: itemSize!)
            var height: CGFloat = 0
            
            let xOffset = (newSize.width + lineSpacing) * CGFloat(modRow)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: xOffset, y: updateHeights[loop][modRow], width: newSize.width, height: newSize.height)
            self.attributes.append(attribute)
            
            height = updateHeights[loop][modRow] + newSize.height + interitemSpacing
            updateHeights[(loop + 1) % 2][modRow] = height
            maxheight = max(height - interitemSpacing, CGFloat(maxheight))
            
            if modRow == 1 {
                loop = (loop + 1) % 2
            }
        }
        
        let footerAtttibute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ACCollectionViewLayout.ACCollectionViewSectionFooter, with: IndexPath(item: 0, section: 0))
        footerAtttibute.frame = CGRect(x: 0, y: self.maxUpdateHeight, width: Layout.SCREEN_WIDTH!, height: sectionFooterHeight)
        attributes.append(footerAtttibute)
        
        contentSize = CGSize(width: collectionView!.frame.width,
                             height: CGFloat(self.maxUpdateHeight + sectionFooterHeight))
    }
}

extension ACCollectionViewLayout {
    func renderScale(itemSize originSize: CGSize) -> CGSize {
        let itemWidth = ((collectionView?.frame.width)! - CGFloat(numberOfRow - 1) * lineSpacing)
            / CGFloat(numberOfRow)
        let scale = itemWidth / originSize.width
        return CGSize(width: itemWidth, height: scale * originSize.height)
    }
    
    var maxUpdateHeight: CGFloat {
        var maxHeight: CGFloat = 0
        for array in updateHeights {
            for height in array {
                maxHeight = max(maxHeight, CGFloat(height))
            }
        }
        return maxHeight
    }
}

protocol ACCollectionViewLayoutDelegate {
    func sizeForItem(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize;
}

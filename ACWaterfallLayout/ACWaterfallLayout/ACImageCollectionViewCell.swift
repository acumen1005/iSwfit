//
//  ACImageCollectionViewCell.swift
//  ACWaterfallLayout
//
//  Created by acumen on 17/3/7.
//  Copyright © 2017年 acumen. All rights reserved.
//

import UIKit

class ACImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var acImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        acImageView.contentMode = .scaleAspectFit
    }

}

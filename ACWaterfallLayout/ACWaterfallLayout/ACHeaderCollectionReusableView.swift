//
//  ACHeaderCollectionReusableView.swift
//  ACWaterfallLayout
//
//  Created by acumen on 17/3/8.
//  Copyright © 2017年 acumen. All rights reserved.
//

import UIKit

class ACHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headerImageView.contentMode = .scaleAspectFill
    }
    
}

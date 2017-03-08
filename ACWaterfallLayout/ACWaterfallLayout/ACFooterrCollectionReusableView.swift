//
//  ACFooterrCollectionReusableView.swift
//  ACWaterfallLayout
//
//  Created by acumen on 17/3/8.
//  Copyright © 2017年 acumen. All rights reserved.
//

import UIKit

class ACFooterrCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var footerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        footerImageView.contentMode = .scaleAspectFill
    }
    
}

//
//  ACHotSearchCell.swift
//  ACSearchViewController
//
//  Created by acumen on 16/11/30.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ACHotSearchCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentLabel.text = "杭州"
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }

    public func setContentLabel(string: String){
        contentLabel.text = string
    }
    
}

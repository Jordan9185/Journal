//
//  MainTableViewCell.swift
//  Journal
//
//  Created by JordanLin on 2017/8/4.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setMainImageViewConfig()
        
        setTitleLabelConfig()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMainImageViewConfig() {
        
        mainImageView.layer.cornerRadius = 8
        
        mainImageView.layer.shadowOpacity = 1
        
        mainImageView.layer.shadowColor = coolGreyColor.cgColor
        
    }
    
    func setTitleLabelConfig() {
        
        titleLabel.font = UIFont(name: ".SFUIText-Regular", size: 14)
        
        titleLabel.font.withSize(14)
        
        titleLabel.textColor = slateColor
        
    }

}

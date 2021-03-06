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
    
    @IBOutlet var grayView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var circleView: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setMainImageViewConfig()
        
        setTitleLabelConfig()
        
        setCircleViewConfig()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMainImageViewConfig() {
        
        mainImageView.layer.cornerRadius = 8
        
        grayView.layer.cornerRadius = 8
        
        grayView.layer.shadowOffset = CGSize.zero
        
        grayView.layer.shadowRadius = 8
        
        grayView.layer.shadowOpacity = 1
        
        grayView.layer.shadowColor = UIColor.black.cgColor
        
    }
    
    func setTitleLabelConfig() {
        
        titleLabel.font = UIFont(name: ".SFUIText-Regular", size: 14)
        
        titleLabel.font.withSize(14)
        
        titleLabel.textColor = slateColor
        
    }

    func setCircleViewConfig() {
        
        circleView.layer.cornerRadius = 4
        
        circleView.layer.borderWidth = 0.5
        
        circleView.layer.borderColor = coolGreyColor.cgColor
        
        circleView.backgroundColor = .white
        
    }
    
}

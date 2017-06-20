//
//  SJSectionCell.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJSectionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)

    }
    
}

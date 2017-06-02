//
//  SJConfigSectionCell.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJConfigSectionCell: UITableViewCell {

    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var printBtn: UIButton!
    
    
    
    var resetBlock: (()->Void)?
    
    var printBlock: (()->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func doReset(_ sender: UIButton) {
        
        resetBlock?()
    }
    
    @IBAction func doPrint(_ sender: UIButton) {
        
        printBlock?()
    }
    
    func hideBtns(hide: Bool) {
        
        resetBtn.isHidden = hide
        printBtn.isHidden = hide
    }
    
    
}

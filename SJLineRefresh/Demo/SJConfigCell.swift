//
//  SJConfigCell.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJConfigCell: UITableViewCell {

    @IBOutlet weak var configNameLabel: UILabel!
    @IBOutlet weak var configValueSlider: UISlider!
    @IBOutlet weak var configValueLabel: UILabel!
    
    var configModel: SJConfigModel? {
        didSet {
            
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func changeValue(_ sender: UISlider) {
        
        configModel?.hasChanged = true
        
    }
    
    
    fileprivate func updateUI() {
        
        configNameLabel.text = configModel?.name
        
        if configModel?.hasChanged ?? false { return }
        
        configValueSlider.maximumValue = Float(configModel?.defaultVaule ?? 0) * 2
        configValueSlider.value = Float(configModel?.defaultVaule ?? 0)
    }

    
    
    

}

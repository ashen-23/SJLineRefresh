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
    @IBOutlet weak var configValueSlider: SJStepSlider!
    @IBOutlet weak var configValueLabel: UILabel!
    
    var configModel: SJConfigModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configValueSlider.changeBlock = { [weak self] value in
            
            self?.configModel?.changeValues(value: value)
//            self?.configModel?.hasChanged = true
            self?.configValueLabel.text = "\(value)"
        }
    }

    fileprivate func updateUI() {
        
        configNameLabel.text = configModel?.name
        
        configValueSlider.step = Float((configModel?.defaultVaule ?? 0) / 10)
        configValueSlider.maximumValue = Float(configModel?.defaultVaule ?? 0) * 2
        configValueLabel.text = "\(configModel?.defaultVaule ?? 0)"

        if configModel?.hasChanged ?? false { return }
        
        configValueSlider.value = Float(configModel?.defaultVaule ?? 0)
    }

    
    
    

}

//
//  SJConfigView.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/5.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJConfigView: UIView {

    @IBOutlet weak var configNameLabel: UILabel!
    @IBOutlet weak var configValueSlider: SJStepSlider!
    @IBOutlet weak var configValueLabel: UILabel!
    
    var mValueChanged: (()->Void)?
    
    var configModel: SJConfigModel? {
        didSet {
            updateUI()
        }
    }
    
    init(config: SJConfigModel) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.sj_width, height: 40))
        addChildViewFromNib()

        self.configModel = config
        updateUI()
        
        configValueSlider.changeBlock = { [weak self] value in
            
            self?.configModel?.changeValues(value: value)
            self?.configValueLabel.text = "\(value)"
            
            self?.mValueChanged?()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addChildViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addChildViewFromNib()
    }
    
    func addChildViewFromNib()
    {
        let subView:UIView =  UINib(nibName:"SJConfigView", bundle: Bundle(for:SJConfigView.self)).instantiate(withOwner: self, options: nil)[0] as! UIView
        subView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        addSubview(subView)
        
    }
    
    func updateUI() {
        
        configNameLabel.text = configModel?.name
        
        configValueSlider.step = Float((configModel?.defaultVaule ?? 0) / 10)
        configValueSlider.maximumValue = Float(configModel?.defaultVaule ?? 0) * 2
        configValueLabel.text = "\(configModel?.defaultVaule ?? 0)"
        
        if configModel?.hasChanged ?? false { return }
        
        configValueSlider.value = Float(configModel?.defaultVaule ?? 0)
    }
}

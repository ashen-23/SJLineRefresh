//
//  SJStepSlider.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJStepSlider: UISlider {

    @IBInspectable var step: Float = 0.1
    
    var changeBlock: ((Float) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        addTarget()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addTarget()
    }

    fileprivate func addTarget() {
        
        self.isContinuous = false

        addTarget(self, action: #selector(changeSlider), for: UIControlEvents.valueChanged)
    }
    
    func changeSlider() {
        
        self.setValue(getRealValue(setted: self.value), animated: true)
        
        changeBlock?(self.value)
    }
    
    func getRealValue(setted: Float) -> Float {
    
        let multiple = Int(setted / step)
        let moreHalf = (setted - step * Float(multiple)) > (step / 2)
        
        return step * Float(multiple + (moreHalf ? 1 : 0))
    }
    
}

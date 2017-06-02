//
//  SJStepSlider.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJStepSlider: UISlider {

    var step: Float = 0.1
    
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
        
        addTarget(self, action: #selector(changeSlider), for: UIControlEvents.valueChanged)
    }
    
    func changeSlider() {
        
        
        changeBlock?(self.value)
    }
    
    func getRealValue(setted: Float) -> Float {
    
        let aCurrent = Int(setted / step)
        let aLast = (setted - step * Float(aCurrent)) > (step / 2)
        
        return step * Float(aCurrent + (aLast ? 1 : 0))
    }
    
}

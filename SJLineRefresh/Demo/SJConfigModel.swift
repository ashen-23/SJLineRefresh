//
//  SJConfigModel.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJConfigModel {

    var name: String?
    
    var defaultVaule: CGFloat?
    
    var hasChanged = false
    
    
    init(name: String, defaultVaule: CGFloat?) {
        self.name = name
        self.defaultVaule = defaultVaule
    }
    
    static func `default`() -> [SJConfigModel] {
        
        var defaults = [SJConfigModel]()
        let aConfig = SJRefreshConfig()
        
        let aDark = SJConfigModel(name: "darkAlpha", defaultVaule: aConfig.darkAlpha)
        defaults.append(aDark)
        
        let aLineWidth = SJConfigModel(name: "lineWidth", defaultVaule: aConfig.lineWidth)
        defaults.append(aLineWidth)
        
        let aDropHeight = SJConfigModel(name: "dropHeight", defaultVaule: aConfig.dropHeight)
        defaults.append(aDropHeight)
        
        
        let aStartRatio = SJConfigModel(name: "startRatio", defaultVaule: aConfig.animConfig.startRatio)
        defaults.append(aStartRatio)
        
        let aEndRatio = SJConfigModel(name: "endRatio", defaultVaule: aConfig.animConfig.endRatio)
        defaults.append(aEndRatio)
        
        let aRandom = SJConfigModel(name: "randomness", defaultVaule: CGFloat(aConfig.animConfig.randomness))
        defaults.append(aRandom)
        
        let aDisappearDuration = SJConfigModel(name: "disappearDuration", defaultVaule: CGFloat(aConfig.animConfig.disappearDuration))
        defaults.append(aDisappearDuration)
        
        let aAnimateFactor = SJConfigModel(name: "animateFactor", defaultVaule: aConfig.animConfig.animateFactor)
        defaults.append(aAnimateFactor)
        
        return defaults
    }
    

}

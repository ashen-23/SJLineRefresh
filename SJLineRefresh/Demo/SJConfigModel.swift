//
//  SJConfigModel.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

enum HHConfigType: String {
    case darkAlpha = "darkAlpha"
    case lineWidth = "lineWidth"
    case dropHeight = "dropHeight"
    case startRatio = "startRatio"
    case endRatio = "endRatio"
    case randomness = "randomness"
    case disappearDuration = "disappearDuration"
    case animateFactor = "animateFactor"
    
    func changeValue(para: Float) {
        
        var defaultConfig = SJRefreshManager.default.defaultConfig
        
        let paraValue = CGFloat(para)
        
        switch self {
        case .darkAlpha:
            
            defaultConfig?.darkAlpha = paraValue
        
        case .lineWidth:
            
            defaultConfig?.lineWidth = paraValue
            
        case .dropHeight:
            
            defaultConfig?.dropHeight = paraValue
        
        case .startRatio:
            
            defaultConfig?.animConfig.startRatio = paraValue
            
        case .endRatio:
            defaultConfig?.animConfig.endRatio = paraValue
    
        case .randomness:
            defaultConfig?.animConfig.randomness = Int(paraValue)
            
        case .disappearDuration:
            
            defaultConfig?.animConfig.disappearDuration = Double(paraValue)
            
        case .animateFactor:
            defaultConfig?.animConfig.animateFactor = paraValue
            
//        default:
//            
//            break
        }
    }
}

class SJConfigModel {

    var name: String?
    
    var type: HHConfigType?
    
    var defaultVaule: CGFloat?
    
    var hasChanged = false
    
    init(type: HHConfigType, defaultVaule: CGFloat?) {
        self.type = type
        self.name = type.rawValue
        self.defaultVaule = defaultVaule
    }
    
    static func `default`() -> [SJConfigModel] {
        
        var defaults = [SJConfigModel]()
        let aConfig = SJRefreshConfig()
        
        let aDark = SJConfigModel(type: HHConfigType.darkAlpha, defaultVaule: aConfig.darkAlpha)
        defaults.append(aDark)
        
        let aLineWidth = SJConfigModel(type: HHConfigType.lineWidth, defaultVaule: aConfig.lineWidth)
        defaults.append(aLineWidth)
        
        let aDropHeight = SJConfigModel(type: HHConfigType.dropHeight, defaultVaule: aConfig.dropHeight)
        defaults.append(aDropHeight)
        
        
        let aStartRatio = SJConfigModel(type: HHConfigType.startRatio, defaultVaule: aConfig.animConfig.startRatio)
        defaults.append(aStartRatio)
        
        let aEndRatio = SJConfigModel(type: HHConfigType.endRatio, defaultVaule: aConfig.animConfig.endRatio)
        defaults.append(aEndRatio)
        
        let aRandom = SJConfigModel(type: HHConfigType.randomness, defaultVaule: CGFloat(aConfig.animConfig.randomness))
        defaults.append(aRandom)
        
        let aDisappearDuration = SJConfigModel(type: HHConfigType.disappearDuration, defaultVaule: CGFloat(aConfig.animConfig.disappearDuration))
        defaults.append(aDisappearDuration)
        
        let aAnimateFactor = SJConfigModel(type: HHConfigType.animateFactor, defaultVaule: aConfig.animConfig.animateFactor)
        defaults.append(aAnimateFactor)
        
        return defaults
    }
    
    func changeValues(value: Float) {
        
        hasChanged = true

        type?.changeValue(para: value)
    }

}

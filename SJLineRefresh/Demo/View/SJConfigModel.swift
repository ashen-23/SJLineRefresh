//
//  SJConfigModel.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import Foundation

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
        
        let paraValue = CGFloat(para)
        
        switch self {
        case .darkAlpha:
            SJRefreshManager.default.defaultConfig.darkAlpha = paraValue
        
        case .lineWidth:
            SJRefreshManager.default.defaultConfig.lineWidth = paraValue
            
        case .dropHeight:
            SJRefreshManager.default.defaultConfig.dropHeight = paraValue
        
        case .startRatio:
            SJRefreshManager.default.defaultConfig.animConfig.startRatio = paraValue
            
        case .endRatio:
            SJRefreshManager.default.defaultConfig.animConfig.endRatio = paraValue
    
        case .randomness:
            SJRefreshManager.default.defaultConfig.animConfig.randomness = Int(paraValue)
            
        case .disappearDuration:
            
            SJRefreshManager.default.defaultConfig.animConfig.animeDuration = Double(paraValue)
            
        case .animateFactor:
            SJRefreshManager.default.defaultConfig.animConfig.animateFactor = paraValue
            
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
    
    func printMe() -> Void {
        
        let aResult = (name ?? "") + ": " + "\(defaultVaule ?? 0)"
        print(aResult)
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
        
        let aDisappearDuration = SJConfigModel(type: HHConfigType.disappearDuration, defaultVaule: CGFloat(aConfig.animConfig.animeDuration))
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


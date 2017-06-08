//
//  SJRefreshManager.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/22.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

public class SJRefreshManager {

    public static let `default` = SJRefreshManager()
    
    public var startPoints: [String]?
    
    public var endPoints: [String]?
    
    public var plistPath: String?
    
    public var defaultConfig: SJRefreshConfig!
    
    init() {
        
        resetConfig()
    }
    
    public func resetConfig() {
        
        let aPath = getCurrentBundle().path(forResource: "HHMedic", ofType: "plist") ?? ""
        defaultConfig = SJRefreshConfig(plist: aPath).build {
            
            $0.lineColor = UIColor(red:47.0/255,green:148.0/255,blue:255.0/255,alpha:1)
            $0.backImg = getImage(name: "hh_refresh_center@3x")
            $0.centerOffset = CGPoint(x: 0.3, y: 0.5)
        }
    }

    public func fetchPoints(path: String) -> ([String]?, [String]?) {
        
        if plistPath != path {
            
            let aDict = NSDictionary.init(contentsOfFile: path)
            startPoints = aDict?.object(forKey: kStartPoints) as? [String]
            endPoints = aDict?.object(forKey: kEndPoints) as? [String]
            plistPath = path
        }
        
        return (startPoints, endPoints)
    }
    
//    public func defaultConfig() -> HHRefreshConfig {
//        
//        let aPath = getCurrentBundle().path(forResource: "HHMedic", ofType: "plist") ?? ""
//        let aConfig = HHRefreshConfig(plist: aPath).build {
//            
//            $0.lineColor = UIColor(red:47.0/255,green:148.0/255,blue:255.0/255,alpha:1)
//            $0.backImg = getImage("hh_refresh_center@3x")
//            $0.imgCenterOffset = CGPoint(x: 0.3, y: 0.5)
//        }
//        
//        return aConfig
//    }
    
}

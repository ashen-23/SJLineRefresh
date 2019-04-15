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
    
    public var defaultConfig = SJRefreshConfig()
    
    public func fetchPoints(path: String) -> ([String]?, [String]?) {
        if plistPath != path {            
            let aDict = NSDictionary.init(contentsOfFile: path)
            startPoints = aDict?.object(forKey: kStartPoints) as? [String]
            endPoints = aDict?.object(forKey: kEndPoints) as? [String]
            plistPath = path
        }
        
        return (startPoints, endPoints)
    }
    

}

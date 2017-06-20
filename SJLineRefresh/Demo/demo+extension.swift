//
//  SJRefreshView+ex.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

extension SJRefreshView {
    
    func reloadView() {
        
        config = SJRefreshManager.default.defaultConfig
        resetUI()
    }
    
    func change(config: SJRefreshConfig) {
        
        self.config = config
        resetUI()
    }
}

extension SJRefreshManager {
    
    func deomConfig() {
        
        let aPath = getCurrentBundle().path(forResource: "HHMedic", ofType: "plist") ?? ""
        SJRefreshManager.default.defaultConfig = SJRefreshConfig(plist: aPath).build {
            
            $0.lineColor = UIColor(red:47.0/255,green:148.0/255,blue:255.0/255,alpha:1)
            $0.backImg = getImage(name: "hh_refresh_center@3x")
            $0.centerOffset = CGPoint(x: 0.3, y: 0.5)
        }
    }
}

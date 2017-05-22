//
//  SJRefreshConfig.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

/// refresh parameters
public struct SJRefreshConfig {

    /// animation configuration parameter
    public var animConfig = SJAnimateConfig()
    
    /// scrollview drop down height
    public var dropHeight: CGFloat = 64

    /// path for plist file with line points
    public var plistPath = ""
    
    /// default path alpha
    public var darkAlpha: CGFloat = 0.4
    
    /// scale
    public var scale: CGFloat  = 1
    
    public var backImg: UIImage?
    
    public var imgCenterOffset : CGPoint?
    
    //MARK: - path's parameter
    
    /// path's line width
    public var lineWidth: CGFloat = 1.5
    
    /// path's line Color
    public var lineColor: UIColor?
    
    /// path's line start point
    var startPoint = CGPoint.zero
    
    /// path's line end point
    var endPoint = CGPoint.zero {
        didSet {
            middlePoint = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        }
    }
    
    /// pathView.s line middle point
    var middlePoint = CGPoint.zero
    
    public init() {
    
    }
    
    /// init
    ///
    /// - Parameter plist: path for plist file with line points
    public init(plist: String) {
        
        plistPath = plist
        
    }
    
    /// config refresh parameters
    ///
    /// - Parameter block: $0.parameter = value
    /// - Returns: SJRefreshConfig
    public func build(_ block: (inout SJRefreshConfig) -> Void) -> SJRefreshConfig {
        var copy = self
        block(&copy)
        return copy
    }
    
}

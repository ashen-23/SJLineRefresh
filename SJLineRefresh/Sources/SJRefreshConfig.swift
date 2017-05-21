//
//  SJRefreshConfig.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

public struct SJRefreshConfig {

    public var dropHeight: CGFloat = 64
    public var animateFactor: CGFloat = 0
    public var randomness: Int = 100 {
        didSet {
            
            if randomness <= 0 {
                randomness = 1
            }
        }
    }

    public var startRatio: CGFloat = 0.3
    
    public var endRatio: CGFloat = 0.9
    
    public var loadingOffset: Int = 100

    public var loadingIndividualTime = 0.8
    
    public var darkAlpha: CGFloat = 0.4

    public var disappearDuration = 0.4
    
    public var scale: CGFloat  = 1
    
    var middlePoint = CGPoint.zero
    
    public var lineWidth: CGFloat = 1.5
    
    var startPoint = CGPoint.zero
    
    var endPoint = CGPoint.zero {
        didSet {
            middlePoint = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        }
    }
    
    public var lineColor: UIColor?
    
    public func build(_ block: (inout SJRefreshConfig) -> Void) -> SJRefreshConfig {
        var copy = self
        block(&copy)
        return copy
    }
    
}

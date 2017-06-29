//
//  SJAnimateConfig.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

public struct SJAnimateConfig {

    public var startRatio: CGFloat = 0.4
    
    public var endRatio: CGFloat = 1
    
    // second
    public var stepLength: TimeInterval = 0.1
    
    public var style = SJAnimateStyle.step
    
    /// step duration  0.8
    public var stepDuration: Double = 0.8
    
    public var disappearDuration = 0.4

    public var animateFactor: CGFloat = 0.9

    public var randomness: Int = 150 {
        didSet {
            
            if randomness <= 0 {
                randomness = 1
            }
        }
    }
    
}

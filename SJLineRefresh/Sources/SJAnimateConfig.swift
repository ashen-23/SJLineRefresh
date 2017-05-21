//
//  SJAnimateConfig.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

public struct SJAnimateConfig {

    public var startRatio: CGFloat = 0.15
    
    public var endRatio: CGFloat = 0.9
    
    public var loadingOffset: Int = 100
    
    public var loadingIndividualTime = 0.8
    
    public var disappearDuration = 0.4

    public var animateFactor: CGFloat = 0

    public var randomness: Int = 100 {
        didSet {
            
            if randomness <= 0 {
                randomness = 1
            }
        }
    }
    
}

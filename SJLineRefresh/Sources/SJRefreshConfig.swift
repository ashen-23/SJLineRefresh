//
//  SJRefreshConfig.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

public struct SJRefreshConfig {

//    fileprivate var scrollView: UIScrollView?
    public var dropHeight: CGFloat = 0
    public var animateFactor: CGFloat?
    public var randomness: Int = 0

    public var scale: CGFloat  = 1
    
    var middlePoint = CGPoint.zero
    
    public var lineWidth: CGFloat = 1
    
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

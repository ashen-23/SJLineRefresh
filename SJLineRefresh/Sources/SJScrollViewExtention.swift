//
//  SJSCrollViewExtention.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

private var key: Void?

public extension UIScrollView {
    
    public var sj_header: SJRefreshView? {
        
        get {
            return objc_getAssociatedObject(self, &key) as? SJRefreshView
        }
        
        set {
            
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            sj_header?.removeFromSuperview()
            if let aHeader = sj_header {
                self.insertSubview(aHeader, at: 0)
            }
            
        }
    }
    
    public func beginRefresh() {
        
    }
    
    public func endRefresh() {
    
        sj_header?.finishLoading()
        
    }
    
    
}

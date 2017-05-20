//
//  SJExtension.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

let SJScreenWidth = UIScreen.main.bounds.size.width

extension CGRect {
    
    var sj_width: CGFloat {
        
        get {
            return size.width
        }
        set {
            size.width = newValue
        }
    }
    
    var sj_height: CGFloat {
        
        get {
            return size.height
        }
        set {
            size.height = newValue
        }
    }
    
    var sj_x: CGFloat {
        
        get {
            return origin.x
        }
        
        set {
            origin.x = newValue
        }
    }
    
    var sj_y: CGFloat {
        
        get {
            return origin.y
        }
        
        set {
            origin.y = newValue
        }
    }
    
}

//
//  SJConstants.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//
import UIKit

let kStartPoints = "startPoints"

let kEndPoints = "endPoints"

let kScrollviewContentPffset = "contentOffset"

public enum SJRefreshState: Int {
    
    case idle = 0
    case pulling
    case willRefresh
    case refresing
    case finish
}


/// animation style
///
/// - normal: default
/// - stay: flash will not disappear
/// - step: add line step by step
/// - reverse: reverse loading direction
public enum SJAnimateStyle: Int {
    
    case normal = 0
    case stay
    case step
    case reverse

    func isStep() -> Bool {
        
        return self == .step
    }
    
    static func allStyles() -> [SJAnimateStyle] {
        
        return [.reverse, .normal, .step, .stay]
    }
}


// 获取当前组件的bundle
func getCurrentBundle() -> Bundle
{
    return Bundle(for: SJRefreshView.self)
}

func getResourceBundle() -> Bundle {
    
    let aURl = getCurrentBundle().url(forResource: "SJLineRefresh", withExtension: "bundle")!
    
    return Bundle(url: aURl)!
}

func getImage(name: String) -> UIImage {
    
    guard let aPath = getResourceBundle().path(forResource: name, ofType: "png") else { return UIImage() }
    return UIImage(contentsOfFile: aPath) ?? UIImage()
}


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

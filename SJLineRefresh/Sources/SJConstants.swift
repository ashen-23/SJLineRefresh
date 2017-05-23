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
    case refresing
    case finish
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

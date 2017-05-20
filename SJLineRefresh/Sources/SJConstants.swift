//
//  SJConstants.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//


let kStartPoints = "startPoints"

let kEndPoints = "endPoints"

let kScrollviewContentPffset = "contentOffset"


public enum SJRefreshState: Int {
    
    case idle = 0
    case pulling
    case refresing
    case finish
}

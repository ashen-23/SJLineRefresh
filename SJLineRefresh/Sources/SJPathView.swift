//
//  SJPathView.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit


public class SJPathView: UIView {

    public lazy var config = SJRefreshConfig()
    
    public var translationX: CGFloat = 0
    
    override public func draw(_ rect: CGRect) {
        
        let aPath = UIBezierPath()
        aPath.move(to: config.startPoint)
        aPath.addLine(to: config.endPoint)
        config.lineColor?.setStroke()
        aPath.lineWidth = config.lineWidth
        aPath.stroke()

    }
    
    public init(frame: CGRect, config: SJRefreshConfig) {
        
        super.init(frame: frame)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    func setUp() {
        
        layer.anchorPoint = CGPoint(x: config.middlePoint.x / frame.size.width, y: config.middlePoint.y / frame.size.height)
        
        frame = CGRect(x: frame.sj_x + config.middlePoint.x - frame.sj_width / 2, y: frame.sj_y + config.middlePoint.y - frame.sj_height / 2, width: frame.sj_width, height: frame.sj_height)
    }
    
    func setRadom() {
        
        translationX = CGFloat(-config.randomness + Int(arc4random()) % config.randomness * 2)
        transform = CGAffineTransform(translationX: translationX, y: -config.dropHeight)
    }

}

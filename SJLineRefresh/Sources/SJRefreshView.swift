//
//  SJRefreshView.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

private let kStartPoints = "startPoints"

private let kEndPoints = "endPoints"

public class SJRefreshView: UIView {

    var refreshBlock: (()->Void)?
    
    lazy var config = SJRefreshConfig()
    
    fileprivate var pullingPercent: CGFloat?
    
    fileprivate var insetTDelta: CGFloat?
    
    fileprivate var scrollView: UIScrollView?
    
    lazy fileprivate var pathViews = [SJPathView]()
    
//    fileprivate var dropHeight: CGFloat?
//    fileprivate var animateFactor: CGFloat?
    
    public class func `default`(config: SJRefreshConfig, refreshBlock: @escaping (()->Void)) -> SJRefreshView {
        
        let aRefreshView = SJRefreshView()
        
        aRefreshView.config = config
        aRefreshView.refreshBlock = refreshBlock
        
        return aRefreshView
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        /*
         CGFloat width = 0;
         CGFloat height = 0;
         NSDictionary *rootDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]];
         NSArray *startPoints = [rootDictionary objectForKey:startPointKey];
         NSArray *endPoints = [rootDictionary objectForKey:endPointKey];
         for (int i=0; i<startPoints.count; i++) {
         
         CGPoint startPoint = CGPointFromString(startPoints[i]);
         CGPoint endPoint = CGPointFromString(endPoints[i]);
         
         if (startPoint.x > width) width = startPoint.x;
         if (endPoint.x > width) width = endPoint.x;
         if (startPoint.y > height) height = startPoint.y;
         if (endPoint.y > height) height = endPoint.y;
         }
         refreshControl.frame = CGRectMake(0, 0, width, height);
         
         // Create bar items
         NSMutableArray *mutableBarItems = [[NSMutableArray alloc] init];
         for (int i=0; i<startPoints.count; i++) {
         
         CGPoint startPoint = CGPointFromString(startPoints[i]);
         CGPoint endPoint = CGPointFromString(endPoints[i]);
         
         BarItem *barItem = [[BarItem alloc] initWithFrame:refreshControl.frame startPoint:startPoint endPoint:endPoint color:color lineWidth:lineWidth];
         barItem.tag = i;
         barItem.backgroundColor=[UIColor clearColor];
         barItem.alpha = 0;
         [mutableBarItems addObject:barItem];
         [refreshControl addSubview:barItem];
         
         [barItem setHorizontalRandomness:refreshControl.horizontalRandomness dropHeight:refreshControl.dropHeight];
         }
         
         refreshControl.barItems = [NSArray arrayWithArray:mutableBarItems];
         refreshControl.frame = CGRectMake(0, 0, width, height);
         refreshControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, - dropHeight / 2);
         for (BarItem *barItem in refreshControl.barItems) {
         [barItem setupWithFrame:refreshControl.frame];
         }
         
         refreshControl.transform = CGAffineTransformMakeScale(scale, scale);
         return refreshControl;
         */
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initUI() {

        

        
    }
    
    fileprivate func parsePath() -> Bool {
        
        guard let aPath = Bundle(for: SJRefreshView.self).path(forResource: "", ofType: "plist") else {
            
            print("path not found")
            return false
        }
        let aDict = NSDictionary.init(contentsOfFile: aPath)
        
        guard let aStarts = aDict?.object(forKey: kStartPoints) as? [String], let aEnds = aDict?.object(forKey: kEndPoints) as? [String]  else { return false }
        
        if aEnds.count != aStarts.count {
            
            print("para count must is equal")
            return false
        }
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        
        for i in 0..<aStarts.count {
            
            let aStart = CGPointFromString(aStarts[i])
            let aEnd = CGPointFromString(aEnds[i])
            
            width = max(width, aStart.x, aEnd.x)
            height = max(height, aStart.y, aEnd.y)
        }
        frame = CGRect(x: 0, y: 0, width: width, height: height)
            
        // create path view
        for i in 0..<aStarts.count {
            
            var aConfig = config
            aConfig.startPoint = CGPointFromString(aStarts[i])
            aConfig.endPoint = CGPointFromString(aEnds[i])
            
            let aPathView = SJPathView(frame: frame, config: aConfig)
            aPathView.tag = i
            aPathView.backgroundColor = UIColor.clear
            aPathView.alpha = 0
            
            addPathViews(view: aPathView)
            
            aPathView.setRadom()
            
            
        }
        
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        center = CGPoint(x: SJScreenWidth / 2, y: -config.dropHeight / 2)
    
        pathViews.forEach { (aView) in
            aView.setUp()
        }
        
        transform = CGAffineTransform(scaleX: config.scale, y: config.scale)
            /*
             // Create bar items
             NSMutableArray *mutableBarItems = [[NSMutableArray alloc] init];
             for (int i=0; i<startPoints.count; i++) {
         
             
             BarItem *barItem = [[BarItem alloc] initWithFrame:refreshControl.frame startPoint:startPoint endPoint:endPoint color:color lineWidth:lineWidth];
             barItem.tag = i;
             barItem.backgroundColor=[UIColor clearColor];
             barItem.alpha = 0;
             [mutableBarItems addObject:barItem];
             [refreshControl addSubview:barItem];
             
             [barItem setHorizontalRandomness:refreshControl.horizontalRandomness dropHeight:refreshControl.dropHeight];
             }
             */
            
        
        
        return true
    }
    
    fileprivate func addPathViews(view: SJPathView) {
        
        addSubview(view)
        pathViews.append(view)
        
    }
    
}

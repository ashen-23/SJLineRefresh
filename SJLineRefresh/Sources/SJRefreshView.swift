//
//  SJRefreshView.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit


public class SJRefreshView: UIView {

    var refreshBlock: (()->Void)?
    
    var config = SJRefreshConfig()
    
    fileprivate var pullingPercent: CGFloat?
    
    fileprivate var insetTDelta: CGFloat = 0
    
    fileprivate var scrollView: UIScrollView?
    
    lazy fileprivate var pathViews = [SJPathView]()
    
    lazy fileprivate var originalInset = UIEdgeInsets.zero
    
    var state = SJRefreshState.idle
        
    public class func `default`(refreshBlock: @escaping (()->Void)) -> SJRefreshView {
        
        let aPath = getCurrentBundle().path(forResource: "HHMedic", ofType: "plist") ?? ""
        let aConfig = SJRefreshConfig(plist: aPath).build {
            
            $0.lineColor = UIColor(red:47.0/255,green:148.0/255,blue:255.0/255,alpha:1)
            $0.backImg = getImage(name: "hh_loading_back@3x")
        }
        
        return SJRefreshView(config: aConfig, refresh: refreshBlock)
    }
    
    public init(config: SJRefreshConfig, refresh: @escaping ()->Void) {
        
        super.init(frame: CGRect.zero)
        
        self.config = config
        self.refreshBlock = refresh
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func initUI() {

        if !parsePath() {
            print("initialize failed")
            return
        }
    }
    
    fileprivate func parsePath() -> Bool {
        
        let points = SJPointsManager.default.fetchPoints(path: config.plistPath)
        
        guard let aStarts = points.0, let aEnds = points.1  else { return false }
        
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
        
        width += config.lineWidth
        height += config.lineWidth
        
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
        
        if let aBackImg = config.backImg {
            
            let aImgView = UIImageView(image: aBackImg)
            
            aImgView.center = CGPoint(x: self.center.x + config.centerOffset.x, y: self.center.y + config.centerOffset.y)
            insertSubview(aImgView, at: 0)
        }
        
        
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        center = CGPoint(x: SJScreenWidth / 2, y: -config.dropHeight / 2)
    
        pathViews.forEach { (aView) in
            aView.setUp()
        }
        
        transform = CGAffineTransform(scaleX: config.scale, y: config.scale)

        return true
    }
    
    fileprivate func addPathViews(view: SJPathView) {
        
        addSubview(view)
        pathViews.append(view)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview is UIScrollView {
            
            scrollView = newSuperview as? UIScrollView
        }
        
        removeObserver()
        addObserver()
        
        initUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let aScroll = scrollView else { return }
        center = CGPoint(x: aScroll.bounds.size.width / 2 + config.centerOffset.x, y: -config.dropHeight / 2 + config.centerOffset.y)
    }
    
}


// MARK: - UIView Animation
extension SJRefreshView {
    
    func startRefresh() {
        
        guard let aScrollView = scrollView else { return }
        state = .refresing
        pullingPercent = 1
        updatePathView()
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.5, animations: {
                let aTop = self.originalInset.top + self.config.dropHeight
                var aInset = aScrollView.contentInset
                aInset.top = aTop
                aScrollView.contentInset = aInset
                
                self.scrollView?.setContentOffset(CGPoint(x: 0, y: -aTop), animated: true)
                
            }, completion: { [weak self] (finish) in
                
                self?.refreshBlock?()
            })
        }
        
        loadingAnimation()
    }
    
    func updatePathView() {
        
        let aPercent = pullingPercent ?? 0
                
        for i in 0..<pathViews.count {
            
            let aPathView = pathViews[i]
            
            let startPadding = (1 - config.animConfig.animateFactor) / CGFloat(pathViews.count) * CGFloat(i)
            let endPadding = 1 - config.animConfig.animateFactor - startPadding
            
            if aPercent == 1 || aPercent >= 1 - endPadding {
                
                aPathView.transform = .identity
                aPathView.alpha = config.darkAlpha
                
            } else if aPercent == 0 {
                aPathView.setRadom()
                
            } else {
                
                let aProgress = aPercent <= startPadding ? 0 : min(1, (aPercent - startPadding) / config.animConfig.animateFactor)
                aPathView.transform = CGAffineTransform(translationX: aPathView.translationX * (1 - aProgress), y: config.dropHeight * (1 - aProgress))
                
                aPathView.transform = aPathView.transform.rotated(by: CGFloat(Double.pi) * aProgress)
                aPathView.transform  = aPathView.transform.scaledBy(x: aProgress, y: aProgress)
                aPathView.alpha = aProgress * config.darkAlpha
                
            }
        }
    }
    
    /// start loading animation
    func loadingAnimation() {
        
        for i in 0..<pathViews.count {
            
            let aTime = DispatchTime.now()  + DispatchTimeInterval.milliseconds(i * config.animConfig.loadingOffset)
            DispatchQueue.main.asyncAfter(deadline: aTime) {
                
                self.animateView(view: self.pathViews[i])
            }
        }
        
    }
    
    func animateView(view: SJPathView) {
        
        if state != .refresing { return }
            
        view.alpha = 1
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: config.animConfig.loadingIndividualTime, animations: {
            
            view.alpha = self.config.darkAlpha
        })
        
        if (view.tag == pathViews.count - 1) && state == .refresing {
            
            loadingAnimation()
        }
    }
    
    func animateDisappear() {
        
        state = .finish
    }
    
    func finishLoading() {
        
        // reset inset and offset
        UIView.animate(withDuration: config.animConfig.disappearDuration, animations: {
            
            guard let aScrollView = self.scrollView else { return }
            var aInset = aScrollView.contentInset
            aInset.top += self.insetTDelta
            self.scrollView?.contentInset = aInset
            
        }) { (finished) in
            
            self.state = .idle
        }

        pathViews.forEach { (aPathView) in
            aPathView.layer.removeAllAnimations()
            aPathView.alpha = config.darkAlpha
        }
    }
    
}


// MARK: - observer
extension SJRefreshView {
    
    func addObserver() {
        
        let aOption: NSKeyValueObservingOptions = [.new, .old]
        scrollView?.addObserver(self, forKeyPath: kScrollviewContentPffset, options: aOption, context: nil)
    }
    
    func removeObserver() {
        
        superview?.removeObserver(self, forKeyPath: kScrollviewContentPffset)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if !isUserInteractionEnabled || isHidden { return }
        
        if keyPath == kScrollviewContentPffset {
            
            contentOffsetChanged(change: change)
        }
        
    }
    
    func contentOffsetChanged(change: [NSKeyValueChangeKey : Any]?) {
        
        guard let aScrollView = scrollView else { return }
        
        if state == .refresing {
            
            if window == nil { return }
            
            var insetTop = max(-aScrollView.contentOffset.y, originalInset.top)
            insetTop = min(config.dropHeight + originalInset.top, insetTop)
            
            insetTDelta = originalInset.top - insetTop
            return
        }

        originalInset = aScrollView.contentInset
        
        let currentOffY = aScrollView.contentOffset.y
        let happendOffY = -originalInset.top
        if currentOffY > happendOffY { return } // 向上滚动到看不见头部控件
        
        let normalOffY = happendOffY - config.dropHeight
        let pullingPercent = (happendOffY - currentOffY) / config.dropHeight
        
        if aScrollView.isDragging { // dragging
        
            redict(pullingPercent: pullingPercent)
            
            if state == .idle {
                
                updatePathView()
                if currentOffY < normalOffY { state = .pulling } // will refresh
                
            } else if state == .pulling && currentOffY >= normalOffY { // normal
                
                state = .idle
            }
            
        } else if state == .pulling { // no in hand & will refresh
            state = .refresing
            DispatchQueue.main.async {

                UIView.animate(withDuration: 0.5, animations: { 
                    let aTop = self.originalInset.top + self.config.dropHeight
                    var aInset = aScrollView.contentInset
                    aInset.top = aTop
                    aScrollView.contentInset = aInset
                    
                    self.scrollView?.setContentOffset(CGPoint(x: 0, y: -aTop), animated: false)
                    
                }, completion: { [weak self] (finish) in
                    
                    self?.refreshBlock?()
                })
            }
            
            loadingAnimation()
            
        } else if pullingPercent < 1 {
            
            self.pullingPercent = pullingPercent
        }
    }
    
    // redic pulling percent
    fileprivate func redict(pullingPercent: CGFloat) {
        
        if pullingPercent <= config.animConfig.startRatio {
            self.pullingPercent = 0
            
        } else if  pullingPercent >= config.animConfig.endRatio {
            self.pullingPercent = 1
            
        } else {
            
            self.pullingPercent = (pullingPercent - config.animConfig.startRatio) / (config.animConfig.endRatio - pullingPercent)
        }
    }
    
}

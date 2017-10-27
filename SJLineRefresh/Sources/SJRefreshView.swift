//
//  SJRefreshView.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

/// refresh view
public class SJRefreshView: UIView {

    var refreshBlock: (()->Void)?
    
    var config = SJRefreshConfig()
    
    fileprivate var pullingPercent: CGFloat?
    fileprivate var insetTDelta: CGFloat = 0
    fileprivate var scrollView: UIScrollView?
    
    lazy fileprivate var pathViews = [SJLinePathView]()
    lazy fileprivate var originalInset = UIEdgeInsets.zero
    
    fileprivate var timer: Timer?
    fileprivate var currentIndex: Int = 0
    
    
    var state = SJRefreshState.idle {
        didSet {
            refreshStateChange(old: oldValue)
        }
    }
        
    public class func `default`(refreshBlock: @escaping (()->Void)) -> SJRefreshView {
        
        return SJRefreshView(config: SJRefreshManager.default.defaultConfig, refresh: refreshBlock)
    }
    
    
    public init(config: SJRefreshConfig, refresh: @escaping ()->Void) {
        
        super.init(frame: CGRect.zero)
        
        self.config = config
        self.refreshBlock = refresh
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.state = .idle
    }

    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if state == .willRefresh {
            state = .refresing
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let aScroll = scrollView else { return }
        center = CGPoint(x: aScroll.bounds.size.width / 2 + config.centerOffset.x, y: -config.dropHeight / 2 + config.centerOffset.y)
    }
    
    /// 刷新状态改变
    func refreshStateChange(old: SJRefreshState) {
        
        if old == state { return }
        guard let aScrollView = scrollView else { return }
        DispatchQueue.main.async {
            self.setNeedsLayout()
        }
        
        if state == .idle {
            if old != .refresing { return }
            
            // 恢复inset
            UIView.animate(withDuration: config.animConfig.animeDuration, animations: {
                
                var aInset = aScrollView.contentInset
                aInset.top += self.insetTDelta
                aScrollView.contentInset = aInset
                
            }, completion: { (isSuccess) in
                
                self.pullingPercent = 0
                self.endTimer()
            })
            
            self.startFinishAnime()
            
        } else if state == .refresing {
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: self.config.animConfig.animeDuration, animations: {
                    let aTop = self.originalInset.top + self.config.dropHeight
                    var aInset = aScrollView.contentInset
                    aInset.top = aTop
                    aScrollView.contentInset = aInset
                    
                    self.scrollView?.setContentOffset(CGPoint(x: 0, y: -aTop), animated: false)
                    
                }, completion: { [weak self] (finish) in
                    
                    self?.refreshBlock?()
                })
            }
            
            startAniam()
        }
    }
}


//MARK: - public func
extension SJRefreshView {
    
    public func beginRefresh() {
        
        pullingPercent = 1
        updatePathView()
        if self.window != nil {
            state = .refresing
        } else {
            
            if state != .refresing {
                state = .willRefresh
                setNeedsDisplay()
            }
        }
    }
    
    public func endRefresh() {
        
        DispatchQueue.main.async {
            
            self.state = .idle
            self.pathViews.forEach { [weak self] (aPathView) in
                aPathView.layer.removeAllAnimations()
                aPathView.alpha = self?.config.darkAlpha ?? 0
            }
            
            
        }
    }
    
    public func resetUI() {
        
        for aView in self.subviews {
            aView.removeFromSuperview()
        }
        
        pathViews = [SJLinePathView]()
        initUI()
    }
}

extension SJRefreshView {

    fileprivate func initUI() {
        
        backgroundColor = UIColor.clear
        
        guard let aScroll = scrollView else { return }
        
        let points = SJRefreshManager.default.fetchPoints(path: config.plistPath)
        
        guard let aStarts = points.0, let aEnds = points.1  else { return }
        
        if aEnds.count != aStarts.count {
            print("para count must is equal")
            return
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
            
            let aPathView = SJLinePathView(frame: frame, config: aConfig)
            aPathView.tag = i
            aPathView.backgroundColor = UIColor.clear
            aPathView.alpha = 0
            
            addPathViews(view: aPathView)
            
            aPathView.setRadom()
        }
        
        if let aBackImg = config.backImg {
            
            let aImgView = UIImageView(image: aBackImg)
            aImgView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            
            aImgView.center = self.center
            insertSubview(aImgView, at: 0)
        }
        
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        center = CGPoint(x: (aScroll.bounds.size.width + width) / 2, y: -config.dropHeight / 2)
        
        pathViews.forEach { (aView) in
            aView.setUp()
        }
        
        transform = CGAffineTransform(scaleX: config.scale, y: config.scale)
    }

    
    fileprivate func addPathViews(view: SJLinePathView) {
        
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
    
}


// MARK: - UIView Animation
extension SJRefreshView {

    func updatePathView() {
        
        let aPercent = pullingPercent ?? 0
        
        let factor = config.animConfig.style.isStep() ? 0 : config.animConfig.animateFactor
        
        for i in 0..<pathViews.count {
            
            let aPathView = pathViews[i]
            
            let startPadding = (1 - factor) / CGFloat(pathViews.count) * CGFloat(i)
            let endPadding = 1 - factor - startPadding
            
            if aPercent == 1 || aPercent >= 1 - endPadding {
                
                aPathView.transform = .identity
                aPathView.alpha = config.darkAlpha
                
            } else if aPercent == 0 {
                
                aPathView.setRadom()
                
            } else {
                
                let aProgress = aPercent <= startPadding ? 0 : min(1, (aPercent - startPadding) / factor)
                aPathView.transform = CGAffineTransform(translationX: aPathView.translationX * (1 - aProgress), y: config.dropHeight * (1 - aProgress))
                
                aPathView.transform = aPathView.transform.rotated(by: CGFloat(Double.pi) * aProgress)
                aPathView.transform  = aPathView.transform.scaledBy(x: aProgress, y: aProgress)
                aPathView.alpha = aProgress * config.darkAlpha
                
            }
        }
    }

    /// make line path flashed
    @objc func flashPath() {
        
        if state != .refresing { return }
        
        if currentIndex >= pathViews.count {
            currentIndex = 0
        }
        
        let aIndex = config.animConfig.style == .reverse ? (pathViews.count - 1 - currentIndex) : currentIndex
        let view = pathViews[aIndex]
        
        currentIndex += 1

        view.layer.removeAllAnimations()
        
        stepAnimation(view: view)
        
        if (aIndex == pathViews.count - 1) && state == .refresing {
            
            cycleAnimation()
        }

    }
    
    @objc func finishAnime() {
        
        pullingPercent = (pullingPercent ?? 1) - CGFloat(1 / 60 / config.animConfig.animeDuration)
        updatePathView()
    }
    
    func stepAnimation(view: SJLinePathView) {
        
        switch config.animConfig.style {
        case .stay:
            
            stayStyle(view)
            
        case .normal: fallthrough
        case .step: fallthrough
        case .reverse:
            
            normalStyle(view)

        }
    }
    
    func cycleAnimation() {
        
        switch config.animConfig.style {
        case .stay:
            
            statyCycle()
           
        case .normal: fallthrough
        case .step: fallthrough
        case .reverse:
            
            normalCycle()

        }
        
    }
    
}

// MARK: - style
extension SJRefreshView {

    func stayStyle(_ view: SJLinePathView) {
        
        view.alpha = config.darkAlpha
        UIView.animate(withDuration: config.animConfig.stepDuration, animations: {
            
            view.alpha = 1
            
        })
    }
    
    func normalStyle(_ view: SJLinePathView) {
        
        view.alpha = 1
        UIView.animate(withDuration: config.animConfig.stepDuration, animations: {
            
            view.alpha = self.config.darkAlpha
        })
    }
    
    func statyCycle() {
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            self.pathViews.forEach{$0.alpha = self.config.darkAlpha}
            
        }) { (finish) in
            
            self.startAniam()
        }
        
    }
    
    func normalCycle() {
        
        startAniam()
    }
}


// MARK: - timer
extension SJRefreshView {
    
    func startAniam() {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: config.animConfig.stepLength, target: self, selector: #selector(flashPath), userInfo: nil, repeats: true)
    }
    
    func startFinishAnime() {
        
        timer?.invalidate()
        
        if !config.animConfig.isDismissAnime { return }
        
        timer = Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(finishAnime), userInfo: nil, repeats: true)
        pullingPercent = 1
    }
    
    
    func endTimer() {
        
        currentIndex = 0
        timer?.invalidate()
        timer = nil
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
            
            var aInset = aScrollView.contentInset
            aInset.top = insetTop
            scrollView?.contentInset = aInset
            
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
            
            beginRefresh()
            
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

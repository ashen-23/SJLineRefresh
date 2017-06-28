//
//  SJStoreHouseController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/20.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJStoreHouseController: SJBaseDemoController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        
        setupRefresh()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.beginRefresh()
    }
    
    func setupRefresh() {
        
        let aPath = Bundle.main.path(forResource: demoType.rawValue, ofType: "plist")!
        let aConfig = SJRefreshConfig(plist: aPath).build {
            
            $0.lineColor = UIColor.white
            $0.lineWidth = 2
            $0.dropHeight = 80
            $0.animConfig.randomness = 150
            $0.animConfig.stepDuration = 0.5
        }
        
        tableView.sj_header = SJRefreshView(config: aConfig, refresh: { [weak self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                
                self?.tableView.endRefresh()
            })
            
        })
        
    }


}

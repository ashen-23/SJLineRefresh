//
//  SJNormalUseController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJNormalUseController: SJBaseDemoController {

    override func viewDidLoad() {
        
        let aPath = Bundle(for: SJNormalUseController.self).path(forResource: "HHMedic", ofType: "plist")!
        let aConfig = SJRefreshConfig(plist: aPath).build {
            
            $0.lineColor = UIColor(red:47.0/255,green:148.0/255,blue:255.0/255,alpha:1)
            $0.backImg = getImage(name: "hh_refresh_center@3x")
            $0.centerOffset = CGPoint(x: 0.3, y: 0.5)
        }
        
        tableView.sj_header = SJRefreshView(config: aConfig) { [weak self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                
                self?.tableView.endRefresh()
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        tableView.beginRefresh()
    }
}


// MARK: - tableView delegate and dataSource
extension SJNormalUseController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        
        aCell.textLabel?.text = demos[indexPath.row]
        aCell.imageView?.image = UIImage(named: "backImg")
        
        return aCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

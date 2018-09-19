//
//  SJBaseDemoController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJBaseDemoController: UIViewController {
    
    var demoType = SJDemoType.polygon
    
    /// config
    var mConfig = SJRefreshConfig()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = demoType.rawValue
        
        tableView.register(UINib(nibName: "SJTableViewCell", bundle: nil), forCellReuseIdentifier: "test")
        tableView.register(UINib(nibName: "SJStyleCell", bundle: nil), forCellReuseIdentifier: "segment")
        tableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsets.init(top: 64, left: 0, bottom: 49, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
    }

}

// MARK: - tableView delegate and dataSource
extension SJBaseDemoController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
           let aCell = tableView.dequeueReusableCell(withIdentifier: "segment", for: indexPath) as! SJStyleCell
            aCell.defaultIndex = mConfig.animConfig.style.rawValue
            
            aCell.changeStyle = { [weak self] in
                
                self?.tableView.sj_header?.config.animConfig.style = $0
            }
            return aCell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 40 : 300
    }
}

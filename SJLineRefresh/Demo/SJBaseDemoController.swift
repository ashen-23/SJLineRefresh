//
//  SJBaseDemoController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/6/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJBaseDemoController: UIViewController {
    
    var demos = [String]()
    
    var demoType = SJDemoType.polygon
    
    /// config
    var mConfig = SJRefreshConfig()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<20 {
            demos.append("this is for test \(i)")
        }
        
    }

}

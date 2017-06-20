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
        tableView.separatorStyle = .none
    }

}

// MARK: - tableView delegate and dataSource
extension SJBaseDemoController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

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
        
        title = demoType.rawValue
    }

}


// MARK: - tableView delegate and dataSource
extension SJBaseDemoController: UITableViewDelegate, UITableViewDataSource {
    
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

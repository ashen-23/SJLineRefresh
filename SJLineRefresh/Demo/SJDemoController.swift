//
//  SJDemoViewController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /// config
    var mConfig = SJRefreshConfig()
    
    fileprivate var demos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<20 {
            demos.append("this is for test \(i)")
        }
        
        tableView.sj_header = SJRefreshView.default {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { 
                
                self.refreshFinish()
            })
        }
        
        startRefresh()
    }
    
    
    fileprivate func startRefresh() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            
            self.tableView.beginRefresh()
        })
    }
    
    
    fileprivate func refreshFinish() {
        
        print("finished")
        tableView.endRefresh()
    }
}



// MARK: - tableView delegate and dataSource
extension SJDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
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

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
    
    var demoType = SJDemoType.polygon
    
    /// config
    var mConfig = SJRefreshConfig()
    
    fileprivate var demos = [String]()
    fileprivate var configInfo = SJConfigModel.default()
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? configInfo.count : demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let aCell = tableView.dequeueReusableCell(withIdentifier: "config", for: indexPath) as! SJConfigCell
            
            
            
            return aCell
        }
        
        let aCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        
        aCell.textLabel?.text = demos[indexPath.row]
        aCell.imageView?.image = UIImage(named: "backImg")

        return aCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 40 : 60
    }
    
    // section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let aView = tableView.dequeueReusableCell(withIdentifier: "section") as! SJConfigSectionCell
        
        aView.hideBtns(hide: section != 0)
        
        return aView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
}

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
    
    @IBOutlet var headerView: SJHeaderView!
    
    var demoType = SJDemoType.polygon
    
    /// config
    var mConfig = SJRefreshConfig()
    
    fileprivate var demos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<20 {
            demos.append("this is for test \(i)")
        }
        
        configRefresh()
        
        initHeader()
        
        startRefresh()
    }
    
    func configRefresh() {
        
        tableView.sj_header = SJRefreshView.default {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                
                self.refreshFinish()
            })
        }
    }
    
    fileprivate func initHeader() {
    
        headerView.frame = headerView.getHeaderFrame(width: tableView.frame.sj_width)
        
        headerView.configChanged = { [weak self] in
            self?.tableView.sj_header?.reloadView()
        }
        headerView.addParaViews()

        tableView.tableHeaderView = headerView
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
    
    @IBAction func doReset(_ sender: UIButton) {
        
        
    }
    
    @IBAction func doPrint(_ sender: UIButton) {
        
        
    }
    
}


// MARK: - tableView delegate and dataSource
extension SJDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
//            
//            let aCell = tableView.dequeueReusableCell(withIdentifier: "config", for: indexPath) as! SJConfigCell
//            
//            aCell.configModel = configInfo[indexPath.row]
//            
//            return aCell
//        }
        
        let aCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        
        aCell.textLabel?.text = demos[indexPath.row]
        aCell.imageView?.image = UIImage(named: "backImg")

        return aCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let aView = tableView.dequeueReusableCell(withIdentifier: "section") as! SJConfigSectionCell
        
//        aView.hideBtns(hide: section != 0)
        
        return aView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
}

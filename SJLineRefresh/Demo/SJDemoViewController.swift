//
//  SJDemoViewController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJDemoViewController: SJBaseDemoController {

    @IBOutlet var headerView: SJHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configRefresh()
        
        initHeader()
        
        startRefresh()
    }
    
    func configRefresh() {
        
        SJRefreshManager.default.deomConfig()
        
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
        
        tableView.endRefresh()
        print("refresh success")
    }
    
    @IBAction func doReset(_ sender: UIButton) {
        
        SJRefreshManager.default.deomConfig()
        
        self.tableView.sj_header?.reloadView()
        
        headerView.resetParas()

    }
    
    @IBAction func doPrint(_ sender: UIButton) {
        
        headerView.configInfo.forEach{$0.printMe()}
    }
}


// MARK: - tableView delegate and dataSource
extension SJDemoViewController {
    
    // section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        return tableView.dequeueReusableCell(withIdentifier: "section")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
}

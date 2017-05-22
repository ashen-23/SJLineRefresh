//
//  ViewController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate var demos: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demos = [String]()
        for i in 0..<20 {
            demos?.append("this is for test \(i)")
        }
        
        guard let aPath = Bundle(for: ViewController.self).path(forResource: "HHMedic", ofType: "plist") else {
            print("path not found")
            return
        }
        
        let aConfig = SJRefreshConfig(plist: aPath).build {
            
            $0.lineColor = UIColor.white
            $0.backImg = UIImage(named: "backImg")
        }
        
        tableView.sj_header = SJRefreshView.default(config: aConfig, refreshBlock: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { 
                
                self.tableView.endRefresh()
            })
            
        })
    }
}



// MARK: - tableView delegate and dataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return demos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let aCell = tableView.dequeueReusableCell(withIdentifier: "SJTestCell", for: indexPath) as? SJTestCell else { return UITableViewCell() }
        
        aCell.centerLabel.text = demos?[indexPath.row]
        
        return aCell
    }
}

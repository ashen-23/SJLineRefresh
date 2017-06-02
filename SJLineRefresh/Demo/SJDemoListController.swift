//
//  SJDemoListController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/25.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit


enum SJDemoType: Int {
    
    case polygon = 0
    
}

class SJDemoListController: UITableViewController {

    lazy var demoType = SJDemoType.polygon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        demoType = SJDemoType(rawValue: indexPath.row) ?? .polygon
        
        performSegue(withIdentifier: "jump2demo", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
    
    

}

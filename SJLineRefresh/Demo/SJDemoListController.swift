//
//  SJDemoListController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/25.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit


enum SJDemoType: String {
    
    case polygon = "polygon"
    case storehouse = "storehouse"
    case AKTA = "AKTA"
    case LOL = "LOL"
    case debug = "debug"
    
    static func enumAllValues() -> [SJDemoType] {
        
        return [.polygon, storehouse, .AKTA, .LOL]
    }
    
    func identifier() -> String {
        
        switch self {

        case .polygon:
            
            return "normal"
            
        case .AKTA: fallthrough
        case .storehouse: fallthrough
        case .LOL:
            
            return "demo"
            
        case .debug:
            
            return "jump2demo"
        }
    }
    
}

class SJDemoListController: UITableViewController {

    lazy var demoType = SJDemoType.polygon
    
    let demos = SJDemoType.enumAllValues()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsets.init(top: 64, left: 0, bottom: 49, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //MARK: - delegate datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? demos.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! SJTestCell
        
        cell.centerLabel.text = demos[indexPath.row].rawValue
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        demoType = demos[indexPath.row]
        
        let identifier = indexPath.section == 1 ? "jump2demo" : demoType.identifier()
        
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! SJBaseDemoController
        
        destination.demoType = demoType
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let aView = tableView.dequeueReusableCell(withIdentifier: "section") as! SJSectionCell
        
        aView.titleLabel.text = section == 0 ? "demo mode" : "debug mode"
        
        return aView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
}

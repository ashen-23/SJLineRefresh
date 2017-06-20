//
//  SJDemoListController.swift
//  SJLineRefresh
//
//  Created by Shi Jian on 2017/5/25.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit


enum SJDemoType: String {
    
    case normal = "normal"
    case polygon = "polygon"
    case storeHouse = "storeHouse"
    case AKTA = "AKTA"
    
    static func enumAllValues() -> [SJDemoType] {
        
        return [.normal, .polygon, storeHouse, .AKTA]
    }
    
    func identifier() -> String {
        
        switch self {
        case .normal:
            
            return self.rawValue

        case .AKTA: fallthrough
        case .storeHouse:
            
            return "storeHouse"
            
        default:
            
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
        
    }
    
    
    //MARK: - delegate datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return demos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! SJTestCell
        
        cell.centerLabel.text = demos[indexPath.row].rawValue
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        demoType = demos[indexPath.row]
        
        performSegue(withIdentifier: demoType.identifier(), sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! SJBaseDemoController
        
        destination.demoType = demoType
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }

}

//
//  SJStyleCell.swift
//  SJLineRefresh
//
//  Created by shiQ on 2017/6/30.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJStyleCell: UITableViewCell {
    
    @IBOutlet weak var segment: UISegmentedControl!

    var changeStyle:((SJAnimateStyle)->Void)?
    
    var defaultIndex = 0 {
        didSet {
            segment.selectedSegmentIndex = defaultIndex
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let styles = ["reverse", "step", "stay", "normal"]
        
        segment.removeAllSegments()

        styles.forEach {
            self.segment.insertSegment(withTitle: $0, at: 0, animated: false)
        }
        
    }

    @IBAction func styleChange(_ sender: UISegmentedControl) {
        
        let aSelect = SJAnimateStyle(rawValue: sender.selectedSegmentIndex)!
        changeStyle?(aSelect)
    }
    
}

//
//  CustomTableViewCell.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/22/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

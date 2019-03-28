//
//  TitleTableViewCell.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/26/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

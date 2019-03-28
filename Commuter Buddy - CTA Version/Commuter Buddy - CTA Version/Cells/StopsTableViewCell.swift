//
//  StopsTableViewCell.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class StopsTableViewCell: UITableViewCell {

    @IBOutlet weak var routeLabel: UILabel! {
        didSet(oldValue) {
            routeLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var desLabel: UILabel! {
        didSet(oldValue) {
            desLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet(oldValue) {
            timeLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var busIdLabel: UILabel! {
        didSet(oldValue) {
            busIdLabel.textColor = UIColor.black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

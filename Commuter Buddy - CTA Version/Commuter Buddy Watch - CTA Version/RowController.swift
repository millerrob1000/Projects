//
//  RowController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/1/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit

class RowController: NSObject {

    @IBOutlet var titleLabel: WKInterfaceLabel! {
        didSet(oldValue) {
            titleLabel.setTextColor(UIColor.white)
        }
    }
    @IBOutlet var subLabel: WKInterfaceLabel! {
        didSet(oldValue) {
            subLabel.setTextColor(UIColor.white)
        }
    }
    @IBOutlet var rowGroup: WKInterfaceGroup!
}

//
//  busRowController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit

class BusRowController: NSObject {

    @IBOutlet var mainLabel: WKInterfaceLabel! {
        didSet(oldValue) {
            mainLabel.setTextColor(UIColor.black)
        }
    }
    @IBOutlet var mainGroup: WKInterfaceGroup!
}

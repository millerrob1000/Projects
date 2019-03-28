//
//  RowControllerStations.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/1/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit

class RowControllerStations: NSObject {
    
    @IBOutlet var stationLabel: WKInterfaceLabel! {
        didSet(oldValue) {
            stationLabel.setTextColor(UIColor.white)
        }
    }
    
    @IBOutlet var stationGroup: WKInterfaceGroup!
}

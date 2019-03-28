//
//  ArrivalController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/4/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit

class ArrivalController: NSObject {
    
    @IBOutlet var direction: WKInterfaceLabel! {
        didSet(oldValue) {
            direction.setTextColor(UIColor.white)
        }
    }
    
    @IBOutlet var time: WKInterfaceLabel! {
        didSet(oldValue) {
            time.setTextColor(UIColor.white)
        }
    }
    
    @IBOutlet var arrivalGroup: WKInterfaceGroup!
}

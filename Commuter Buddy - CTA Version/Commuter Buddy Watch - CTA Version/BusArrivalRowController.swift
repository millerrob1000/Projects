//
//  BusArrivalRowController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit

class BusArrivalRowController: NSObject {

    @IBOutlet var time: WKInterfaceLabel! {
        didSet(oldValue) {
            time.setTextColor(UIColor.black)
        }
    }
    @IBOutlet var vehicleId: WKInterfaceLabel! {
        didSet(oldValue) {
            vehicleId.setTextColor(UIColor.black)
        }
    }
    @IBOutlet var direction: WKInterfaceLabel! {
        didSet(oldValue) {
            direction.setTextColor(UIColor.black)
        }
    }
    @IBOutlet var routeNumber: WKInterfaceLabel! {
        didSet(oldValue) {
            routeNumber.setTextColor(UIColor.black)
        }
    }
    
    @IBOutlet var mainGroup: WKInterfaceGroup!
}

//
//  StopsInterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import WatchConnectivity


class StopsInterfaceController: WKInterfaceController {
    
    var timer: Timer?
    var color: UIColor?
    var route: String?
    var flag: Bool = true
    @IBOutlet var stopsTable: WKInterfaceTable!
    @IBOutlet var noDataLabel: WKInterfaceLabel!
    @IBOutlet var gettingDataLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
      
        if let passed: [String:UIColor] = context as? [String:UIColor] {
            for (key, value) in passed {
                color = value
                route = key
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        gettingDataLabel.setTextColor(UIColor.white)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpTable), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
        WatchData.busArrivalArray = [ArrivalBusStops]()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    @objc func setUpTable() {
        if WatchData.stopsArray.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
            
            stopsTable.setNumberOfRows(WatchData.stopsArray.count, withRowType: "stopController")
            for i in 0..<stopsTable.numberOfRows {
                let theRow = stopsTable.rowController(at: i) as? StopRowController
                let dataObj = WatchData.stopsArray[i]
                theRow?.mainLabel.setText(dataObj.stpnm)
                theRow?.mainGroup.setBackgroundColor(color)
            }
        }else if !flag {
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(false)
            noDataLabel.setTextColor(UIColor.white)
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let stopid = WatchData.stopsArray[rowIndex].stpid
        WKInterfaceDevice.current().play(.click)
        
        WCSession.default.sendMessage(["busArrivals":[route, stopid]], replyHandler: { (reply: [String:Any]) -> Void in
            let value = reply["busArrivalsReply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(ArrivalBusStops.self, forClassName: "ArrivalBusStops")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                WatchData.busArrivalArray = decoded as! [ArrivalBusStops]
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        return color
    }
    
    @objc func setFlag() {
        flag = false
    }

}

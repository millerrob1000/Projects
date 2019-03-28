//
//  DirectionsInterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import WatchConnectivity


class DirectionsInterfaceController: WKInterfaceController {

    @IBOutlet var noDataLabel: WKInterfaceLabel!
    @IBOutlet var gettingDataLabel: WKInterfaceLabel!
    @IBOutlet var directTable: WKInterfaceTable!
    var color: UIColor?
    var route: String?
    var timer: Timer?
    var flag: Bool = true
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let passedColor: [UIColor:String] = context as? [UIColor:String] {
            for (key, value) in passedColor {
                color = key
                route = value
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        gettingDataLabel.setTextColor(UIColor.white)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpTable), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
        WatchData.stopsArray = [Stops]()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    @objc func setUpTable() {
        if WatchData.directionsArray.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
            
        directTable.setNumberOfRows(WatchData.directionsArray.count, withRowType: "directionsController")
        for i in 0..<directTable.numberOfRows {
            let theRow = directTable.rowController(at: i) as? DirectionsRowController
            let dataObj = WatchData.directionsArray[i]
            theRow?.mainLabel.setText(dataObj.dir)
            theRow?.mainGroup.setBackgroundColor(color)
            }
        }else if !flag {
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(false)
            noDataLabel.setTextColor(UIColor.white)
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let direct = WatchData.directionsArray[rowIndex].dir
        WKInterfaceDevice.current().play(.click)
        
        WCSession.default.sendMessage(["stops":[route, direct]], replyHandler: { (reply: [String:Any]) -> Void in
            let value = reply["stopsReply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(Stops.self, forClassName: "Stops")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                WatchData.stopsArray = decoded as! [Stops]
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        let dict: [String:UIColor] = [route!:color!]
        return dict
    }
    
    @objc func setFlag() {
        flag = false
    }

}

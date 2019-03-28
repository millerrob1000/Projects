//
//  FavoritesInterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/12/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import WatchConnectivity

class FavoritesInterfaceController: WKInterfaceController {

    @IBOutlet var noDataLabel: WKInterfaceLabel!
    @IBOutlet var gettingDataLabel: WKInterfaceLabel!    
    @IBOutlet var favTable: WKInterfaceTable!
    var timer: Timer?
    var flag: Bool = true
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WKInterfaceDevice.current().play(.click)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        WatchData.arrivalsArray = [Arrivals]()
        WatchData.busArrivalArray = [ArrivalBusStops]()
        
        WCSession.default.sendMessage(["favoritesWatch":"send"], replyHandler: {(reply: [String:Any]) -> Void in
            let value = reply["favWatchReply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(Stations.self, forClassName: "Stations")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                WatchData.favArray = decoded as! [Stations]
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpTable), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
        
        gettingDataLabel.setTextColor(UIColor.white)
        setUpTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    @objc func setUpTable() {
        if WatchData.favArray.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
            
            favTable.setNumberOfRows(WatchData.favArray.count, withRowType: "favoritesRowController")
            for i in 0..<favTable.numberOfRows {
                let theRow = favTable.rowController(at: i) as? FavoritesRowController
                let dataObj = WatchData.favArray[i]
                
                if dataObj.name != "" {
                    theRow?.favoritesName.setText(dataObj.name)
                }else{
                    theRow?.favoritesName.setText(dataObj.stpnm)
                    theRow?.favoritesName.setTextColor(UIColor.black)
                }
                
                if dataObj.type == "" {
                    theRow?.mainGroup.setBackgroundColor(dataObj.stopColor)
                }else{
                theRow?.mainGroup.setBackgroundColor(getColor(dataObj.type))
                }
                
                if dataObj.type == "y" {
                    theRow?.favoritesName.setTextColor(UIColor.black)
                }
            }
        }else if !flag {
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(false)
            noDataLabel.setTextColor(UIColor.white)
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        WKInterfaceDevice.current().play(.click)
        
        switch WatchData.favArray[rowIndex].name {
        case "":
            WCSession.default.sendMessage(["busArrivals":[WatchData.favArray[rowIndex].route, WatchData.favArray[rowIndex].stpid]], replyHandler: { (reply: [String:Any]) -> Void in
                let value = reply["busArrivalsReply"] as? Data
                if value != nil {
                    NSKeyedUnarchiver.setClass(ArrivalBusStops.self, forClassName: "ArrivalBusStops")
                    let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                    WatchData.busArrivalArray = decoded as! [ArrivalBusStops]
                }
            }, errorHandler: { error in
                print(error.localizedDescription)
            })
            pushController(withName: "busArrivals", context: WatchData.favArray[rowIndex].stopColor)
        default:
            WCSession.default.sendMessage(["arrivals":WatchData.favArray[rowIndex].mapID], replyHandler: { (reply: [String:Any]) -> Void in
                let value = reply["arrivalsReply"] as? Data
                if value != nil {
                    NSKeyedUnarchiver.setClass(Arrivals.self, forClassName: "Arrivals")
                    let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                    WatchData.arrivalsArray = decoded as! [Arrivals]
                }
            }, errorHandler: { error in
                print(error.localizedDescription)
            })
            pushController(withName: "Arrivals", context: nil)
        }
        return nil
    }
    
    @objc func setFlag() {
        flag = false
    }
}

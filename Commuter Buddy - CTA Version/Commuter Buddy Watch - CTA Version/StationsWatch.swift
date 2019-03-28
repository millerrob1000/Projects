//
//  StationsWatch.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/1/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//
struct WatchData{
    static var stationsArray = [Stations]()
    static var arrivalsArray = [Arrivals]()
    static var directionsArray = [Directions]()
    static var stopsArray = [Stops]()
    static var busArrivalArray = [ArrivalBusStops]()
    static var favArray = [Stations]()
}

import WatchKit
import WatchConnectivity

class StationsWatch: WKInterfaceController {
    
    @IBOutlet var stationTable: WKInterfaceTable!
    @IBOutlet var noDataLabel: WKInterfaceLabel!
    @IBOutlet var gettingDataLabel: WKInterfaceLabel!
    var timer: Timer?
    var flag: Bool = true
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        gettingDataLabel.setTextColor(UIColor.white)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpTable), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
        
        WatchData.arrivalsArray = [Arrivals]()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let mapID = WatchData.stationsArray[rowIndex].mapID
        WKInterfaceDevice.current().play(.click)
        
        WCSession.default.sendMessage(["arrivals":mapID], replyHandler: { (reply: [String:Any]) -> Void in
            let value = reply["arrivalsReply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(Arrivals.self, forClassName: "Arrivals")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                WatchData.arrivalsArray = decoded as! [Arrivals]
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        return nil
    }
    
    @objc func setUpTable() {
        if WatchData.stationsArray.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
            
        stationTable.setNumberOfRows(WatchData.stationsArray.count, withRowType: "rowControllerStations")
        for i in 0..<stationTable.numberOfRows {
            let theRow = stationTable.rowController(at: i) as? RowControllerStations
            let dataObj = WatchData.stationsArray[i]
            theRow?.stationLabel.setText(dataObj.name)
            theRow?.stationGroup.setBackgroundColor(getColor(dataObj.type))
            
            if dataObj.type == "y" {
                theRow?.stationLabel.setTextColor(UIColor.black)
                }
            }
        }else if !flag {
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(false)
            noDataLabel.setTextColor(UIColor.white)
        }
    }
    
    @objc func setFlag() {
        flag = false
    }
}

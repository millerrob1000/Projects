//
//  BusesInterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import WatchConnectivity


class BusesInterfaceController: WKInterfaceController {
    
    var busRoutes = [Routes]()
    var timer: Timer?
    var flag: Bool = true
    @IBOutlet var routeTable: WKInterfaceTable!
    @IBOutlet var noDataLabel: WKInterfaceLabel!
    @IBOutlet var gettingDataLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WKInterfaceDevice.current().play(.click)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        gettingDataLabel.setTextColor(UIColor.white)
        
        WCSession.default.sendMessage(["busRoute":""], replyHandler: {(reply: [String:Any]) -> Void in
            let value = reply["busRouteReply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(Routes.self, forClassName: "Routes")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                self.busRoutes = decoded as! [Routes]
                for i in self.busRoutes {
                    print(i)
                }
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpTable), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
        
        WatchData.directionsArray = [Directions]()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    @objc func setUpTable() {
        if busRoutes.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
        routeTable.setNumberOfRows(busRoutes.count, withRowType: "busRowController")
        for i in 0..<routeTable.numberOfRows {
            let theRow = routeTable.rowController(at: i) as? BusRowController
            let dataObj = busRoutes[i]
            theRow?.mainLabel.setText(dataObj.rtnm)
            theRow?.mainGroup.setBackgroundColor(dataObj.rtclr)
            }
        }else if !flag {
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(false)
            noDataLabel.setTextColor(UIColor.white)
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let route = busRoutes[rowIndex].rt
        let color = busRoutes[rowIndex].rtclr
        WKInterfaceDevice.current().play(.click)
        
        WCSession.default.sendMessage(["directions":route], replyHandler: { (reply: [String:Any]) -> Void in
            let value = reply["directionsReply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(Directions.self, forClassName: "Directions")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                WatchData.directionsArray = decoded as! [Directions]
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        let dict: [UIColor:String] = [color:route]
        return dict
        }
    
    @objc func setFlag() {
        flag = false
        }
    }

//
//  InterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 11/30/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var mainRailLines: WKInterfaceTable!
    var trains = lines
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WKInterfaceDevice.current().play(.click)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        setUpTable()
        WatchData.stationsArray = [Stations]()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setUpTable() {
            mainRailLines.setNumberOfRows(trains.count, withRowType: "rowController")
            for i in 0..<mainRailLines.numberOfRows {
                let theRow = mainRailLines.rowController(at: i) as? RowController
                let dataObj = trains[i]
                theRow?.titleLabel.setText(dataObj.name)
                theRow?.subLabel.setText(dataObj.routes)
                theRow?.rowGroup.setBackgroundColor(getColor(dataObj.type.rawValue))
                
                if dataObj.type.rawValue == "y" {
                    theRow?.titleLabel.setTextColor(UIColor.black)
                    theRow?.subLabel.setTextColor(UIColor.black)
                }
            }
        }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let type = trains[rowIndex].type.rawValue
        WKInterfaceDevice.current().play(.click)
        
        WCSession.default.sendMessage(["request":type], replyHandler: { (reply: [String:Any]) -> Void in
            let value = reply["reply"] as? Data
            if value != nil {
                NSKeyedUnarchiver.setClass(Stations.self, forClassName: "Stations")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                WatchData.stationsArray = decoded as! [Stations]
            }
        }, errorHandler: { error in
            print(error.localizedDescription)
        })
        return nil
    }
}

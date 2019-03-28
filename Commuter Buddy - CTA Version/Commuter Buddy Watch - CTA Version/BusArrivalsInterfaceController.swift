//
//  BusArrivalsInterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import Foundation


class BusArrivalsInterfaceController: WKInterfaceController {

    var timer: Timer?
    var color: UIColor?
    var flag: Bool = true
    @IBOutlet var arrivalTable: WKInterfaceTable!
    @IBOutlet var noDataLabel: WKInterfaceLabel!
    @IBOutlet var gettingDataLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let passedValue: UIColor = context as? UIColor {
            color = passedValue
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        gettingDataLabel.setTextColor(UIColor.white)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpTable), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    @objc func setUpTable() {
        if WatchData.busArrivalArray.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
            
            arrivalTable.setNumberOfRows(WatchData.busArrivalArray.count, withRowType: "busArrivalRowController")
            for i in 0..<arrivalTable.numberOfRows {
                let theRow = arrivalTable.rowController(at: i) as? BusArrivalRowController
                let dataObj = WatchData.busArrivalArray[i]
            
                if dataObj.prdctdn == "DUE" {
                    theRow?.time.setText(dataObj.prdctdn)
                }else{
                    theRow?.time.setText("\(dataObj.prdctdn) MINS")
                }
                
                theRow?.vehicleId.setText(dataObj.vid)
                theRow?.direction.setText("To \(dataObj.des)")
                theRow?.routeNumber.setText(dataObj.rt)
                theRow?.mainGroup.setBackgroundColor(color)
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

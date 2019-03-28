//
//  ArrivalsWatch.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/4/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import Foundation


class ArrivalsWatch: WKInterfaceController {

    @IBOutlet var arrivalTable: WKInterfaceTable!
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
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.setFlag), userInfo: nil, repeats: false)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer?.invalidate()
    }
    
    @objc func setUpTable() {
        if WatchData.arrivalsArray.count > 0 {
            timer?.invalidate()
            gettingDataLabel.setHidden(true)
            noDataLabel.setHidden(true)
        
        arrivalTable.setNumberOfRows(WatchData.arrivalsArray.count, withRowType: "arrivalsController")
        for i in 0..<arrivalTable.numberOfRows {
            let theRow = arrivalTable.rowController(at: i) as? ArrivalController
            let dataObj = WatchData.arrivalsArray[i]
            theRow?.direction.setText(dataObj.stopDes)
        
            if dataObj.isApproch == "1" {
                theRow?.time.setText("DUE")
            }else if dataObj.isDly == "1" {
                theRow?.time.setText("DELAYED")
            }else if dataObj.isApproch == "0" || dataObj.isDly == "0" {
                theRow?.time.setText(dataObj.finalTime + " mins")
            }
            
            theRow?.arrivalGroup.setBackgroundColor(getColorArrivals(dataObj.route))
            
            if dataObj.route == "Y" {
                theRow?.direction.setTextColor(UIColor.black)
                theRow?.time.setTextColor(UIColor.black)
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

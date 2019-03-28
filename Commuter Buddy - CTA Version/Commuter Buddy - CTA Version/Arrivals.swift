//
//  Arrivals.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/25/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class Arrivals: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(route, forKey: "route")
        aCoder.encode(stopDes, forKey: "stopDes")
        aCoder.encode(finalTime, forKey: "finalTime")
        aCoder.encode(isApproch, forKey: "isApproch")
        aCoder.encode(isDly, forKey: "isDly")
        aCoder.encode(trDr, forKey: "trDr")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let route = aDecoder.decodeObject(forKey: "route") as! String
        let stopDes = aDecoder.decodeObject(forKey: "stopDes") as! String
        let finalTime = aDecoder.decodeObject(forKey: "finalTime") as! String
        let isApproch = aDecoder.decodeObject(forKey: "isApproch") as! String
        let isDly = aDecoder.decodeObject(forKey: "isDly") as! String
        let trDr = aDecoder.decodeObject(forKey: "trDr") as! String
        self.init(route, stopDes, finalTime, isApproch, isDly, trDr)
    }
    
    var route: String
    var stopDes: String
    var finalTime: String
    var isApproch: String
    var isDly: String
    var trDr: String
    
    init(_ route: String, _ stopDes: String, _ finalTime: String, _ isApproch: String, _ isDly: String, _ trDr: String) {
        self.route = route
        self.stopDes = stopDes
        self.finalTime = finalTime
        self.isApproch = isApproch
        self.isDly = isDly
        self.trDr = trDr
    }
}

func getColorArrivals(_ type: String) -> UIColor{
    
    switch(type){
    case "Red":
        return UIColor(red: 198/255.0, green: 48/255.0, blue: 12/255.0, alpha: 1.0)
    case "Blue":
        return UIColor(red: 0/255.0, green: 161/255.0, blue: 222/255.0, alpha: 1.0)
    case "Brn":
        return UIColor(red: 98/255.0, green: 54/255.0, blue: 27/255.0, alpha: 1.0)
    case "G":
        return UIColor(red: 0/255.0, green: 155/255.0, blue: 58/255.0, alpha: 1.0)
    case "Org":
        return UIColor(red: 249/255.0, green: 70/255.0, blue: 28/255.0, alpha: 1.0)
    case "P":
        return UIColor(red: 82/255.0, green: 35/255.0, blue: 152/255.0, alpha: 1.0)
    case "Pink":
        return UIColor(red: 226/255.0, green: 126/255.0, blue: 166/255.0, alpha: 1.0)
    case "Y":
        return UIColor(red: 249/255.0, green: 227/255.0, blue: 0/255.0, alpha: 1.0)
    default:
        return UIColor.black
    }
}

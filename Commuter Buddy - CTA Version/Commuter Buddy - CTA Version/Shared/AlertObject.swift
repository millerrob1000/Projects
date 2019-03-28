//
//  AlertObject.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/29/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class AlertObject: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(alertId, forKey: "alertId")
        aCoder.encode(headLine, forKey: "headLine")
        aCoder.encode(shortDes, forKey: "shortDes")
        aCoder.encode(impact, forKey: "impact")
        aCoder.encode(serviceName, forKey: "serviceName")
        aCoder.encode(serviceId, forKey: "serviceId")
        aCoder.encode(serviceBackColor, forKey: "serviceBackColor")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let alertId = aDecoder.decodeObject(forKey: "alertId") as! String
        let headLine = aDecoder.decodeObject(forKey: "headLine") as! String
        let shortDes = aDecoder.decodeObject(forKey: "shortDes") as! String
        let impact = aDecoder.decodeObject(forKey: "impact") as! String
        let serviceName = aDecoder.decodeObject(forKey: "serviceName") as! String
        let serviceId = aDecoder.decodeObject(forKey: "serviceId") as! String
        let serviceBackColor = (aDecoder.decodeObject(forKey: "serviceBackColor") as! UIColor).htmlRGB
        self.init(alertId: alertId, headLine: headLine, shortDes: shortDes, impact: impact, serviceName: serviceName, serviceId: serviceId, serviceBackColor: serviceBackColor)
    }
    
    var alertId: String
    var headLine: String
    var shortDes: String
    var impact: String
    var serviceName: String
    var serviceId: String
    var serviceBackColor: UIColor
    
    init(alertId: String, headLine: String, shortDes: String, impact: String, serviceName: String, serviceId: String, serviceBackColor: String) {
        self.alertId = alertId
        self.headLine = headLine
        self.shortDes = shortDes
        self.impact = impact
        self.serviceName = serviceName
        self.serviceId = serviceId
        self.serviceBackColor = UIColor(hexString: serviceBackColor)
    }
}

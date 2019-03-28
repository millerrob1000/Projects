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
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let alertId = aDecoder.decodeObject(forKey: "alertId") as! String
        let headLine = aDecoder.decodeObject(forKey: "headLine") as! String
        let shortDes = aDecoder.decodeObject(forKey: "shortDes") as! String
        let impact = aDecoder.decodeObject(forKey: "impact") as! String
        let serviceName = aDecoder.decodeObject(forKey: "serviceName") as! String
        let serviceId = aDecoder.decodeObject(forKey: "serviceId") as! String
        self.init(alertId, headLine, shortDes, impact, serviceName, serviceId)
    }
    
    var alertId: String
    var headLine: String
    var shortDes: String
    var impact: String
    var serviceName: String
    var serviceId: String
    
    init(_ alertId: String, _ headLine: String, _ shortDes: String, _ impact: String, _ serviceName: String, _ serviceId: String) {
        self.alertId = alertId
        self.headLine = headLine
        self.shortDes = shortDes
        self.impact = impact
        self.serviceName = serviceName
        self.serviceId = serviceId
    }
}

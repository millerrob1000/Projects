//
//  Stations.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/24/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

@objc(Stations)
class Stations: NSObject, NSCoding {
    
    var name: String
    var mapID: String
    var type: String
    var stpid: String
    var stpnm: String
    var stopColor: UIColor
    var route: String
    
    init(_ name: String = "", _ mapID: String = "", _ type: String = "", _ stpid: String = "", _ stpnm: String = "", _ stopColor: UIColor = UIColor.clear, _ route: String = ""){
        self.name = name
        self.mapID = mapID
        self.type = type
        self.stpid = stpid
        self.stpnm = stpnm
        self.stopColor = stopColor
        self.route = route
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(mapID, forKey: "mapID")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(stpid, forKey: "stpid")
        aCoder.encode(stpnm, forKey: "stpnm")
        aCoder.encode(stopColor, forKey: "stopColor")
        aCoder.encode(route, forKey: "route")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let mapID = aDecoder.decodeObject(forKey: "mapID") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        guard let stpid = aDecoder.decodeObject(forKey: "stpid") as? String else { return nil }
        guard let stpnm = aDecoder.decodeObject(forKey: "stpnm") as? String else { return nil }
        guard let stopColor = aDecoder.decodeObject(forKey: "stopColor") as? UIColor else { return nil }
        guard let route = aDecoder.decodeObject(forKey: "route") as? String else { return nil }
        self.init(name, mapID, type, stpid, stpnm, stopColor, route)        
    }
}


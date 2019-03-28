//
//  Stops.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class Stops: NSObject, NSCoding {
    
    var stpid: String
    var stpnm: String
    
    init(stpid: String, stpnm: String) {
        self.stpid = stpid
        self.stpnm = stpnm
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stpid, forKey: "stpid")
        aCoder.encode(stpnm, forKey: "stpnm")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let stpid = aDecoder.decodeObject(forKey: "stpid") as! String
        let stpnm = aDecoder.decodeObject(forKey: "stpnm") as! String
        self.init(stpid: stpid, stpnm: stpnm)
    }

}

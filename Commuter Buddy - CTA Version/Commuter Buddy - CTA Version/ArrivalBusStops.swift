//
//  ArrivalBusStops.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class ArrivalBusStops: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(rt, forKey: "rt")
        aCoder.encode(des, forKey: "des")
        aCoder.encode(prdctdn, forKey: "prd")
        aCoder.encode(vid, forKey: "vid")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let rt = aDecoder.decodeObject(forKey: "rt") as? String else { return nil }
        guard let des = aDecoder.decodeObject(forKey: "des") as? String else { return nil }
        guard let prdctdn = aDecoder.decodeObject(forKey: "prd") as? String else { return nil }
        guard let vid = aDecoder.decodeObject(forKey: "vid") as? String else { return nil }
        self.init(rt, des, prdctdn, vid)
    }
    
    var rt: String
    var des: String
    var prdctdn: String
    var vid: String
    
    init(_ rt: String, _ des: String, _ prdctdn: String, _ vid: String) {
        self.rt = rt
        self.des = des
        self.prdctdn = prdctdn
        self.vid = vid
    }
}

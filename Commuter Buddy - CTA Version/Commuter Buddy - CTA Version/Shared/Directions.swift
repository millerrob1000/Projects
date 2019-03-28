//
//  Directions.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class Directions: NSObject, NSCoding {
    
    var dir: String
    
    init(_ dir: String) {
        self.dir = dir
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dir, forKey: "dir")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let dir = aDecoder.decodeObject(forKey: "dir") as! String
        self.init(dir)
    }
}

//
//  Routes.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class Routes: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(rt, forKey: "rt")
        aCoder.encode(rtnm, forKey: "rtnm")
        aCoder.encode(rtclr, forKey: "rtclr")
        aCoder.encode(rtdd, forKey: "rtdd")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let rt = aDecoder.decodeObject(forKey: "rt") as! String
        let rtnm = aDecoder.decodeObject(forKey: "rtnm") as! String
        let rtclr = (aDecoder.decodeObject(forKey: "rtclr") as! UIColor).htmlRGB
        let rtdd = aDecoder.decodeObject(forKey: "rtdd") as! String
        self.init(rt: rt, rtnm: rtnm, rtclr: rtclr, rtdd: rtdd)
    }
    
    var rt: String
    var rtnm: String
    var rtclr: UIColor
    var rtdd: String
    
    init(rt: String, rtnm: String, rtclr: String, rtdd: String) {
        self.rt = rt
        self.rtnm = rtnm
        self.rtclr = UIColor(hexString: rtclr)
        self.rtdd = rtdd
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0, 0, 0, 0)
    }
    
    // hue, saturation, brightness and alpha components from UIColor**
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return (hue, saturation, brightness, alpha)
        }
        return (0,0,0,0)
    }
    
    var htmlRGB: String {
        return String(format: "#%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255))
    }
    
    var htmlRGBA: String {
        return String(format: "#%02x%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255) )
    }
}

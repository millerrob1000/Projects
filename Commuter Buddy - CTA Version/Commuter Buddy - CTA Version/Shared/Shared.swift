//
//  Shared.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/4/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//
struct railInfo {
    static var trains: [Lines] = lines
    static var railStationsWatch: [Stations] = [Stations]()
    static var favArray: [Stations] = [Stations]()
}

import Foundation
import UIKit

func insertItems() {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: railInfo.favArray)
    UserDefaults.standard.set(encodedData, forKey: "favorites")
    UserDefaults.standard.synchronize()
}

func retrieveItems() {
    let decoded = UserDefaults.standard.object(forKey: "favorites") as! Data
    let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Stations]
    railInfo.favArray = decodedArray
    UserDefaults.standard.synchronize()
}

func getTypeAlerts(_ type: String) -> String {
    switch type {
    case "red":
        return "Red"
    case "blue":
        return "Blue"
    case "brn":
        return "Brn"
    case "g":
        return "G"
    case "o":
        return "Org"
    case "pnk":
        return "Pink"
    case "p":
        return "Pexp"
    case "y":
        return "Y"
    default:
        return ""
    }
}

// MARK: - Round bottom corners only
extension UIView {
    func roundCorners(radius: Double, corners: CACornerMask) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
}

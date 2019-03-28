//
//  Lines.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/22/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

class Lines {
    
    enum `Type`: String {
        case red = "red"
        case blue = "blue"
        case brn = "brn"
        case g = "g"
        case o = "o"
        case p = "p"
        case pnk = "pnk"
        case y = "y" }
    
    var name: String
    var type: Type
    var routes: String
    
    init(_ name: String, _ type: Type, _ routes: String) {
        self.name = name
        self.type = type
        self.routes = routes
    }
}
    var lines = [
        Lines("Red", .red, "Howard-95th/Dan-Ryan"),
        Lines("Blue", .blue, "O'Hare-Forest Park"),
        Lines("Brown", .brn, "Kimball-Loop"),
        Lines("Green", .g, "Harlem/Lake-Ashland/63rd-Cottage Grv"),
        Lines("Orange", .o, "Midway-Loop"),
        Lines("Purple", .p, "Linden-Howard-Loop"),
        Lines("Pink", .pnk, "54th/Cermak-Loop"),
        Lines("Yellow", .y, "Skokie-Howard")]

func getColor(_ type: String) -> UIColor{
    
    switch(type){
    case "red":
        return UIColor(red: 198/255.0, green: 48/255.0, blue: 12/255.0, alpha: 1.0)
    case "blue":
        return UIColor(red: 0/255.0, green: 161/255.0, blue: 222/255.0, alpha: 1.0)
    case "brn":
        return UIColor(red: 98/255.0, green: 54/255.0, blue: 27/255.0, alpha: 1.0)
    case "g":
        return UIColor(red: 0/255.0, green: 155/255.0, blue: 58/255.0, alpha: 1.0)
    case "o":
        return UIColor(red: 249/255.0, green: 70/255.0, blue: 28/255.0, alpha: 1.0)
    case "p":
        return UIColor(red: 82/255.0, green: 35/255.0, blue: 152/255.0, alpha: 1.0)
    case "pnk":
        return UIColor(red: 226/255.0, green: 126/255.0, blue: 166/255.0, alpha: 1.0)
    case "y":
        return UIColor(red: 249/255.0, green: 227/255.0, blue: 0/255.0, alpha: 1.0)
    default:
        return UIColor.black
    }
}




















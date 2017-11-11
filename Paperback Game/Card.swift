//
//  Card.swift
//  RMiller_Final_Project
//
//  Created by Rob on 2/18/17.
//  Copyright © 2017 Rob. All rights reserved.
//

import Foundation
import UIKit

class Card{
    enum `Type`: String{
        case ch = "ch"
        case ar = "ar"
        case at = "at"
        case a = "a"
        case e = "e"
        case i = "i"
        case o = "o"
        case u = "u"
        case l = "l"
        case n = "n"
        case r = "r"
        case s = "s"
        case t = "t"
        case wild1 = "wild1"
        case wild5 = "wild5"
        case wild8 = "wild8"
        case wild11 = "wild11"
        case wild17 = "wild17"
        case an = "an"
        case ed = "ed"
        case en = "en"
        case er = "er"
        case es = "es"
        case it = "it"
        case ng = "ng"
        case nt = "nt"
        case on = "on"
        case or = "or"
        case re = "re"
        case se = "se"
        case st = "st"
        case te = "te"
        case ti = "ti"
        case aCommon = "aCommon"
        case eCommon = "eCommon"
        case iCommon = "iCommon"
        case oCommon = "oCommon"
        case z = "z"
        case y = "y"
        case x = "x"
        case w = "w"
        case v = "v"
        case lStart = "lStart"
        case nStart = "nStart"
        case rStart = "rStart"
        case sStart = "sStart"
        case tStart = "tStart"
        case q = "q"
        case p = "p"
        case m = "m"
        case k = "k"
        case j = "j"
        case h = "h"
        case g = "g"
        case f = "f"
        case d = "d"
        case c = "c"
        case b = "b"
    }
    var name: String
    var points: Int
    var cost: Int
    var type: Type
    var endGamePoint: Int
    
    init(name: String, points: Int, cost: Int, type: Type, endGamePoint: Int){
        self.name = name
        self.points = points
        self.cost = cost
        self.type = type
        self.endGamePoint = endGamePoint
    }
}

var deck = [
    Card(name: "a", points: 2, cost: 2, type: .a, endGamePoint: 0),
    Card(name: "e", points: 2, cost: 2, type: .e, endGamePoint: 0),
    Card(name: "i", points: 2, cost: 2, type: .i, endGamePoint: 0),
    Card(name: "o", points: 2, cost: 2, type: .o, endGamePoint: 0),
    Card(name: "a", points: 2, cost: 2, type: .a, endGamePoint: 0),
    Card(name: "e", points: 2, cost: 2, type: .e, endGamePoint: 0),
    Card(name: "i", points: 2, cost: 2, type: .i, endGamePoint: 0),
    Card(name: "o", points: 2, cost: 2, type: .o, endGamePoint: 0),
    Card(name: "s", points: 1, cost: 3, type: .s, endGamePoint: 0),
    Card(name: "s", points: 1, cost: 3, type: .s, endGamePoint: 0),
    Card(name: "t", points: 1, cost: 3, type: .t, endGamePoint: 0),
    Card(name: "t", points: 1, cost: 3, type: .t, endGamePoint: 0),
    Card(name: "l", points: 1, cost: 3, type: .l, endGamePoint: 0),
    Card(name: "es", points: 2, cost: 3, type: .es, endGamePoint: 0),
    Card(name: "en", points: 2, cost: 3, type: .en, endGamePoint: 0),
    Card(name: "er", points: 2, cost: 3, type: .er, endGamePoint: 0),
    Card (name: "at", points: 2, cost: 3, type: .at, endGamePoint: 0),
    Card(name: "an", points: 2, cost: 3, type: .an, endGamePoint: 0),
    Card(name: "on", points: 3, cost: 3, type: .on, endGamePoint: 0),
    Card(name: "ti", points: 2, cost: 3, type: .ti, endGamePoint: 0),
    Card(name: "d", points: 2, cost: 4, type: .d, endGamePoint: 0),
    Card(name: "r", points: 1, cost: 4, type: .r, endGamePoint: 0),
    Card(name: "t", points: 1, cost: 4, type: .t, endGamePoint: 0),
    Card(name: "s", points: 1, cost: 4, type: .s, endGamePoint: 0),
    Card(name: "m", points: 2, cost: 4, type: .m, endGamePoint: 0),
    Card(name: "ch", points: 3, cost: 4, type: .ch, endGamePoint: 0),
    Card (name: "ar", points: 3, cost: 4, type: .ar, endGamePoint: 0),
    Card(name: "ed", points: 3, cost: 4, type: .ed, endGamePoint: 0),
    Card(name: "ng", points: 3, cost: 4, type: .ng, endGamePoint: 0),
    Card(name: "st", points: 3, cost: 4, type: .st, endGamePoint: 0),
    Card(name: "b", points: 3, cost: 5, type: .b, endGamePoint: 0),
    Card(name: "c", points: 2, cost: 5, type: .c, endGamePoint: 0),
    Card(name: "nt", points: 3, cost: 4, type: .nt, endGamePoint: 0),
    Card(name: "or", points: 3, cost: 4, type: .or, endGamePoint: 0),
    Card(name: "re", points: 2, cost: 3, type: .re, endGamePoint: 0),
    Card(name: "se", points: 3, cost: 4, type: .se, endGamePoint: 0),
    Card(name: "te", points: 2, cost: 3, type: .te, endGamePoint: 0),
    Card(name: "g", points: 3, cost: 5, type: .g, endGamePoint: 0),
    Card(name: "l", points: 1, cost: 5, type: .l, endGamePoint: 0),
    Card(name: "l", points: 1, cost: 5, type: .l, endGamePoint: 0),
    Card(name: "m", points: 2, cost: 5, type: .m, endGamePoint: 0),
    Card(name: "n", points: 1, cost: 5, type: .n, endGamePoint: 0),
    Card(name: "n", points: 1, cost: 5, type: .n, endGamePoint: 0),
    Card(name: "r", points: 1, cost: 5, type: .r, endGamePoint: 0),
    Card(name: "y", points: 3, cost: 5, type: .y, endGamePoint: 0),
    Card(name: "y", points: 3, cost: 5, type: .y, endGamePoint: 0),
    Card(name: "p", points: 2, cost: 5, type: .p, endGamePoint: 0),
    Card(name: "d", points: 2, cost: 5, type: .d, endGamePoint: 0),
    Card(name: "b", points: 3, cost: 6, type: .b, endGamePoint: 0),
    Card(name: "f", points: 4, cost: 6, type: .f, endGamePoint: 0),
    Card(name: "g", points: 3, cost: 6, type: .g, endGamePoint: 0),
    Card(name: "h", points: 3, cost: 6, type: .h, endGamePoint: 0),
    Card(name: "u", points: 2, cost: 6, type: .u, endGamePoint: 0),
    Card(name: "u", points: 2, cost: 6, type: .u, endGamePoint: 0),
    Card(name: "v", points: 4, cost: 6, type: .v, endGamePoint: 0),
    Card(name: "w", points: 4, cost: 6, type: .w, endGamePoint: 0),
    Card(name: "w", points: 4, cost: 6, type: .w, endGamePoint: 0),
    Card(name: "r", points: 1, cost: 6, type: .r, endGamePoint: 0),
    Card(name: "c", points: 2, cost: 6, type: .c, endGamePoint: 0),
    Card(name: "n", points: 1, cost: 6, type: .n, endGamePoint: 0),
    Card(name: "f", points: 4, cost: 6, type: .f, endGamePoint: 0),
    Card(name: "z", points: 5, cost: 7, type: .z, endGamePoint: 0),
    Card(name: "b", points: 3, cost: 7, type: .b, endGamePoint: 0),
    Card(name: "u", points: 2, cost: 7, type: .u, endGamePoint: 0),
    Card(name: "z", points: 5, cost: 7, type: .z, endGamePoint: 0),
    Card(name: "z", points: 5, cost: 8, type: .z, endGamePoint: 0),
    Card(name: "y", points: 3, cost: 8, type: .y, endGamePoint: 0),
    Card(name: "x", points: 5, cost: 8, type: .x, endGamePoint: 0),
    Card(name: "x", points: 5, cost: 8, type: .x, endGamePoint: 0),
    Card(name: "x", points: 5, cost: 8, type: .x, endGamePoint: 0),
    Card(name: "w", points: 4, cost: 9, type: .w, endGamePoint: 0),
    Card(name: "w", points: 4, cost: 9, type: .w, endGamePoint: 0),
    Card(name: "v", points: 4, cost: 7, type: .v, endGamePoint: 0),
    Card(name: "v", points: 4, cost: 7, type: .v, endGamePoint: 0),
    Card(name: "v", points: 2, cost: 7, type: .v, endGamePoint: 0),
    Card(name: "v", points: 4, cost: 7, type: .v, endGamePoint: 0),
    Card(name: "q", points: 5, cost: 7, type: .q, endGamePoint: 0),
    Card(name: "q", points: 5, cost: 10, type: .q, endGamePoint: 0),
    Card(name: "q", points: 5, cost: 10, type: .q, endGamePoint: 0),
    Card(name: "p", points: 2, cost: 5, type: .p, endGamePoint: 0),
    Card(name: "p", points: 2, cost: 7, type: .p, endGamePoint: 0),
    Card(name: "m", points: 2, cost: 7, type: .m, endGamePoint: 0),
    Card(name: "k", points: 1, cost: 7, type: .k, endGamePoint: 0),
    Card(name: "k", points: 4, cost: 7, type: .k, endGamePoint: 0),
    Card(name: "k", points: 4, cost: 8, type: .k, endGamePoint: 0),
    Card(name: "j", points: 5, cost: 7, type: .j, endGamePoint: 0),
    Card(name: "j", points: 5, cost: 10, type: .j, endGamePoint: 0),
    Card(name: "j", points: 5, cost: 8, type: .j, endGamePoint: 0),
    Card(name: "h", points: 3, cost: 7, type: .h, endGamePoint: 0),
    Card(name: "h", points: 3, cost: 8, type: .h, endGamePoint: 0),
    Card(name: "g", points: 3, cost: 8, type: .g, endGamePoint: 0),
    Card(name: "f", points: 4, cost: 8, type: .f, endGamePoint: 0),
    Card(name: "d", points: 2, cost: 7, type: .d, endGamePoint: 0),
    Card(name: "c", points: 2, cost: 7, type: .c, endGamePoint: 0)]

var common = [
    Card(name: "a", points: 1, cost: 0, type: .aCommon, endGamePoint: 5),
    Card(name: "e", points: 1, cost: 0, type: .eCommon, endGamePoint: 5),
    Card(name: "i", points: 1, cost: 0, type: .iCommon, endGamePoint: 5),
    Card(name: "o", points: 1, cost: 0, type: .oCommon, endGamePoint: 5)]

var startingHand = [
    Card(name: "l", points: 1, cost: 1, type: .lStart, endGamePoint: 0),
    Card(name: "n", points: 1, cost: 1, type: .nStart, endGamePoint: 0),
    Card(name: "r", points: 1, cost: 1, type: .rStart, endGamePoint: 0),
    Card(name: "s", points: 1, cost: 1, type: .sStart, endGamePoint: 0),
    Card(name: "t", points: 1, cost: 1, type: .tStart, endGamePoint: 0),
    Card(name: "wild1", points: 0, cost: 2, type: .wild1, endGamePoint: 1),
    Card(name: "wild1", points: 0, cost: 2, type: .wild1, endGamePoint: 1),
    Card(name: "wild1", points: 0, cost: 2, type: .wild1, endGamePoint: 1),
    Card(name: "wild1", points: 0, cost: 2, type: .wild1, endGamePoint: 1),
    Card(name: "wild1", points: 0, cost: 2, type: .wild1, endGamePoint: 1)]

var wildFiveCent = [
    Card(name: "wild5", points: 0, cost: 5, type: .wild5, endGamePoint: 4),
    Card(name: "wild5", points: 0, cost: 5, type: .wild5, endGamePoint: 4),
    Card(name: "wild5", points: 0, cost: 5, type: .wild5, endGamePoint: 4),
    Card(name: "wild5", points: 0, cost: 5, type: .wild5, endGamePoint: 4)]

var wildEightCent = [
    Card(name: "wild8", points: 0, cost: 8, type: .wild8, endGamePoint: 7),
    Card(name: "wild8", points: 0, cost: 8, type: .wild8, endGamePoint: 7),
    Card(name: "wild8", points: 0, cost: 8, type: .wild8, endGamePoint: 7),
    Card(name: "wild8", points: 0, cost: 8, type: .wild8, endGamePoint: 7)]

var wildElevenCent = [
    Card(name: "wild11", points: 0, cost: 11, type: .wild11, endGamePoint: 10),
    Card(name: "wild11", points: 0, cost: 11, type: .wild8, endGamePoint: 10)]

var wildSeventeenCent = [
    Card(name: "wild17", points: 0, cost: 17, type: .wild17, endGamePoint: 15)]

var discard = [Card]()

extension MutableCollection where Indices.Iterator.Element == Index{ //warning is bug in Swift 4
    mutating func shuffle(){
        let c = count
        guard c > 1 else { return }
        for(firstUnshuffled, unshuffeledCount) in zip(indices, stride(from: c, to: 1, by: -1)){
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffeledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
}
extension Sequence{
    func shuffled() -> [Iterator.Element]{
        var result = Array(self)
        result.shuffle()
        return result
    }
}

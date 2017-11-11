//
//  Player2Deck.swift
//  RMiller_Final_Project
//
//  Created by Rob on 3/2/17.
//  Copyright © 2017 Rob. All rights reserved.
//

import Foundation
import UIKit

class Player2{
    enum `Type`: String{
        case rot = "rot"
        case rots = "rots"
        case tot = "tot"
        case tots = "tots"
        case not = "not"
        case nots = "nots"
        case lost = "lost"
        case lot = "lot"
        case lots = "lots"
        case no = "no"
        case nor = "nor"
        case nos = "nos"
        case on = "on"
        case or = "or"
        case ors = "ors"
        case slot = "slot"
        case snort = "snort"
        case snot = "snot"
        case so = "so"
        case sol = "sol"
        case son = "son"
        case sort = "sort"
        case sot = "sot"
        case to = "to"
        case ton = "ton"
        case tons = "tons"
        case torn = "torn"
        case ant = "ant"
        case ants = "ants"
        case ar = "ar"
        case ars = "ars"
        case art = "art"
        case arts = "arts"
        case `as` = "as"
        case at = "at"
        case last = "last"
        case ran = "ran"
        case rant = "rant"
        case rants = "rants"
        case rat = "rat"
        case rats = "rats"
        case slant = "slant"
        case snarl = "snarl"
        case salt = "salt"
        case star = "star"
        case tarns = "tarns"
        case tsar = "tsar"
        case slat = "slat"
        case `in` = "in"
        case ins = "ins"
        case `is` = "is"
        case it = "it"
        case its = "its"
        case lint = "lint"
        case list = "list"
        case lit = "lit"
        case `nil` = "nil"
        case nils = "nils"
        case nit = "nit"
        case nits = "nits"
        case silt = "silt"
        case sin = "sin"
        case sir = "sir"
        case sit = "sit"
        case snit = "snit"
        case stir = "stir"
        case tin = "tin"
        case tins = "tins"
        case el = "el"
        case els = "els"
        case en = "en"
        case ens = "ens"
        case lens = "lens"
        case lent = "lent"
        case lest = "lest"
        case `let` = "let"
        case lets = "lets"
        case nest = "nest"
        case net = "net"
        case nets = "nets"
        case re = "re"
        case rent = "rent"
        case rents = "rents"
        case rest = "rest"
        case sent = "sent"
        case set = "set"
        case stern = "stern"
        case ten = "ten"
        case tens = "tens"
        case tern = "tern"
        case terns = "terns"
        case lust = "lust"
        case nu = "nu"
        case nus = "nus"
        case nut = "nut"
        case nuts = "nuts"
        case run = "run"
        case runs = "runs"
        case runt = "runt"
        case runts = "runts"
        case rust = "rust"
        case rut = "rut"
        case ruts = "ruts"
        case slur = "slur"
        case stun = "stun"
        case sun = "sun"
        case turn = "turn"
        case turns = "turns"
        case un = "un"
        case urn = "urn"
        case urns = "urns"
        case us = "us"
        case alter = "alter"
        case antes = "antes"
        case lanes = "lanes"

    }
    var points: Int
    var type: Type
    var endGamePoints: Int
    var name: String
    
    init(name: String, points: Int, type: Type, endGamePoints: Int){
        self.name = name
        self.points = points
        self.type = type
        self.endGamePoints = endGamePoints
        }
    }

var startingDeck = [
    Player2(name: "lanes", points: 5, type: .lanes, endGamePoints: 0),
    Player2(name: "antes", points: 5, type: .antes, endGamePoints: 0),
    Player2(name: "alter", points: 5, type: .alter, endGamePoints: 0),
    Player2(name: "lust", points: 4, type: .lust, endGamePoints: 0),
    Player2(name: "nu", points: 2, type: .nu, endGamePoints: 0),
    Player2(name: "nus", points: 3, type: .nus, endGamePoints: 0),
    Player2(name: "nut", points: 3, type: .nut, endGamePoints: 0),
    Player2(name: "nuts", points: 4, type: .nuts, endGamePoints: 0),
    Player2(name: "run", points: 3, type: .run, endGamePoints: 0),
    Player2(name: "runs", points: 4, type: .runs, endGamePoints: 0),
    Player2(name: "runt", points: 4, type: .runt, endGamePoints: 0),
    Player2(name: "runts", points: 5, type: .runts, endGamePoints: 0),
    Player2(name: "rust", points: 4, type: .rust, endGamePoints: 0),
    Player2(name: "rut", points: 3, type: .rut, endGamePoints: 0),
    Player2(name: "ruts", points: 4, type: .ruts, endGamePoints: 0),
    Player2(name: "slur", points: 4, type: .slur, endGamePoints: 0),
    Player2(name: "stun", points: 4, type: .stun, endGamePoints: 0),
    Player2(name: "sun", points: 3, type: .sun, endGamePoints: 0),
    Player2(name: "turn", points: 4, type: .turn, endGamePoints: 0),
    Player2(name: "turns", points: 5, type: .turns, endGamePoints: 0),
    Player2(name: "un", points: 2, type: .un, endGamePoints: 0),
    Player2(name: "urn", points: 3, type: .urn, endGamePoints: 0),
    Player2(name: "urns", points: 4, type: .urns, endGamePoints: 0),
    Player2(name: "us", points: 2, type: .us, endGamePoints: 0),
    Player2(name: "el", points: 2, type: .el, endGamePoints: 0),
    Player2(name: "els", points: 3, type: .els, endGamePoints: 0),
    Player2(name: "en", points: 2, type: .en, endGamePoints: 0),
    Player2(name: "ens", points: 3, type: .ens, endGamePoints: 0),
    Player2(name: "lens", points: 4, type: .lens, endGamePoints: 0),
    Player2(name: "lent", points: 4, type: .lent, endGamePoints: 0),
    Player2(name: "lest", points: 4, type: .lest, endGamePoints: 0),
    Player2(name: "let", points: 3, type: .let, endGamePoints: 0),
    Player2(name: "lets", points: 4, type: .lets, endGamePoints: 0),
    Player2(name: "nets", points: 4, type: .nets, endGamePoints: 0),
    Player2(name: "re", points: 2, type: .re, endGamePoints: 0),
    Player2(name: "rent", points: 4, type: .rent, endGamePoints: 0),
    Player2(name: "rents", points: 5, type: .rents, endGamePoints: 0),
    Player2(name: "rest", points: 4, type: .rest, endGamePoints: 0),
    Player2(name: "sent", points: 4, type: .sent, endGamePoints: 0),
    Player2(name: "set", points: 3, type: .set, endGamePoints: 0),
    Player2(name: "stern", points: 5, type: .stern, endGamePoints: 0),
    Player2(name: "ten", points: 3, type: .ten, endGamePoints: 0),
    Player2(name: "tens", points: 4, type: .tens, endGamePoints: 0),
    Player2(name: "tern", points: 4, type: .tern, endGamePoints: 0),
    Player2(name: "terns", points: 5, type: .terns, endGamePoints: 0),
    Player2(name: "in", points: 2, type: .in, endGamePoints: 0),
    Player2(name: "ins", points: 3, type: .ins, endGamePoints: 0),
    Player2(name: "is", points: 2, type: .is, endGamePoints: 0),
    Player2(name: "it", points: 2, type: .it, endGamePoints: 0),
    Player2(name: "its", points: 3, type: .its, endGamePoints: 0),
    Player2(name: "lint", points: 4, type: .lint, endGamePoints: 0),
    Player2(name: "list", points: 4, type: .list, endGamePoints: 0),
    Player2(name: "lit", points: 3, type: .lit, endGamePoints: 0),
    Player2(name: "nil", points: 3, type: .nil, endGamePoints: 0),
    Player2(name: "nils", points: 4, type: .nils, endGamePoints: 0),
    Player2(name: "nit", points: 3, type: .nit, endGamePoints: 0),
    Player2(name: "nits", points: 4, type: .nits, endGamePoints: 0),
    Player2(name: "silt", points: 4, type: .silt, endGamePoints: 0),
    Player2(name: "sin", points: 3, type: .sin, endGamePoints: 0),
    Player2(name: "sir", points: 3, type: .sir, endGamePoints: 0),
    Player2(name: "sit", points: 3, type: .sit, endGamePoints: 0),
    Player2(name: "snit", points: 4, type: .snit, endGamePoints: 0),
    Player2(name: "stir", points: 4, type: .stir, endGamePoints: 0),
    Player2(name: "tin", points: 3, type: .tin, endGamePoints: 0),
    Player2(name: "tins", points: 4, type: .tins, endGamePoints: 0),
    Player2(name: "rot", points: 3, type: .rot, endGamePoints: 0),
    Player2(name: "rots", points: 4, type: .rot, endGamePoints: 0),
    Player2(name: "tot", points: 3, type: .tot, endGamePoints: 0),
    Player2(name: "tots", points: 4, type: .tot, endGamePoints: 0),
    Player2(name: "not", points: 3, type: .not, endGamePoints: 0),
    Player2(name: "nots", points: 4, type: .nots, endGamePoints: 0),
    Player2(name: "nots", points: 4, type: .nots, endGamePoints: 0),
    Player2(name: "lost", points: 4, type: .lost, endGamePoints: 0),
    Player2(name: "lot", points: 3, type: .lot, endGamePoints: 0),
    Player2(name: "lots", points: 4, type: .lots, endGamePoints: 0),
    Player2(name: "no", points: 2, type: .nots, endGamePoints: 0),
    Player2(name: "or", points: 2, type: .or, endGamePoints: 0),
    Player2(name: "ors", points: 3, type: .ors, endGamePoints: 0),
    Player2(name: "slot", points: 4, type: .slot, endGamePoints: 0),
    Player2(name: "snort", points: 5, type: .snort, endGamePoints: 0),
    Player2(name: "snot", points: 4, type: .snot, endGamePoints: 0),
    Player2(name: "so", points: 2, type: .so, endGamePoints: 0),
    Player2(name: "sol", points: 3, type: .sol, endGamePoints: 0),
    Player2(name: "son", points: 3, type: .son, endGamePoints: 0),
    Player2(name: "sort", points: 4, type: .sort, endGamePoints: 0),
    Player2(name: "sot", points: 3, type: .sot, endGamePoints: 0),
    Player2(name: "to", points: 2, type: .to, endGamePoints: 0),
    Player2(name: "ton", points: 3, type: .ton, endGamePoints: 0),
    Player2(name: "tons", points: 4, type: .tons, endGamePoints: 0),
    Player2(name: "torn", points: 4, type: .nots, endGamePoints: 0),
    Player2(name: "ant", points: 3, type: .ant, endGamePoints: 0),
    Player2(name: "ants", points: 4, type: .ant, endGamePoints: 0),
    Player2(name: "ar", points: 2, type: .ar, endGamePoints: 0),
    Player2(name: "ars", points: 3, type: .ars, endGamePoints: 0),
    Player2(name: "art", points: 3, type: .art, endGamePoints: 0),
    Player2(name: "arts", points: 4, type: .arts, endGamePoints: 0),
    Player2(name: "as", points: 2, type: .as, endGamePoints: 0),
    Player2(name: "at", points: 2, type: .at, endGamePoints: 0),
    Player2(name: "last", points: 4, type: .last, endGamePoints: 0),
    Player2(name: "ran", points: 3, type: .ran, endGamePoints: 0),
    Player2(name: "rant", points: 4, type: .rant, endGamePoints: 0),
    Player2(name: "rants", points: 5, type: .rants, endGamePoints: 0),
    Player2(name: "rat", points: 3, type: .rat, endGamePoints: 0),
    Player2(name: "rats", points: 4, type: .rats, endGamePoints: 0),
    Player2(name: "slant", points: 5, type: .slant, endGamePoints: 0),
    Player2(name: "snarl", points: 5, type: .snarl, endGamePoints: 0),
    Player2(name: "salt", points: 4, type: .salt, endGamePoints: 0),
    Player2(name: "star", points: 4, type: .star, endGamePoints: 0),
    Player2(name: "tarns", points: 5, type: .tarns, endGamePoints: 0),
    Player2(name: "tsar", points: 4, type: .tsar, endGamePoints: 0),
    Player2(name: "slat", points: 4, type: .slat, endGamePoints: 0)
   ]

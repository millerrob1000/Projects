//
//  JSONManager.swift
//  Commuter Buddy - CTA Version
//
//  Created by Miller III, Rob on 8/20/18.
//  Copyright © 2018 Max OSX. All rights reserved.
//

import Foundation

// MARK: - TRAIN JSON FUNCTIONS
// MARK: - Function for parsing stations JSON
func getStations(_ type: String, completion: @escaping (_ stationList: [Stations], _ error: NSError?) -> Void){
    
    let stationFeed = "https://data.cityofchicago.org/resource/8mj8-j3c4.json"
    var stationList: [Stations] = []
    var dynamicType: Bool?
    guard let url = URL(string: stationFeed) else { return }
    
    //Takes data and decodes it from the structs.  [Station] is for a JSON array with no name at the beginning
    guard let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode([Station].self, from: data) else { return }
    
    for item in task {
        switch type {
        case "red":
            dynamicType = item.red
        case "blue":
            dynamicType = item.blue
        case "brn":
            dynamicType = item.brn
        case "g":
            dynamicType = item.g
        case "o":
            dynamicType = item.o
        case "p":
            dynamicType = item.p
        case "pnk":
            dynamicType = item.pnk
        default:
            dynamicType = item.y
        }
        
        guard let stationName = item.station_name,
            let mapid = item.map_id else { return }
        
        if dynamicType ?? false && stationName != "95th/Ran Ryan" {
            stationList.append(Stations(stationName, mapid, type))
        }
    }
    completion(stationList.unique(map: {$0.name}).sorted(by: {$0.name < $1.name}), .none)
}

// MARK: - Function to parse Arrival JSON
func getArrivals(_ mapId: String, completion: @escaping (_ stationArrivals: [Arrivals], _ error: NSError?) -> Void) {
    
    let feed = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=59d25f874f544e8daf237b1e5859d7a9&mapid=" + mapId + "&outputType=JSON"
    var stationArrivals: [Arrivals] = []
    var northbound: [Arrivals] = []
    var southbound: [Arrivals] = []
    
    guard let url = URL(string: feed) else { return }
    
    guard let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode(Root.self, from: data),
        let etaArray = task.ctatt?.eta else { return }
    
    for item in etaArray {
        guard let route = item.rt,
            let stopDes = item.destNm,
            let arrTime = item.arrT,
            let prdTime = item.prdt,
            let isApproch = item.isApp,
            let isDly = item.isDly,
            let trDr = item.trDr else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let format = dateFormatter.date(from: arrTime),
            let format2 = dateFormatter.date(from: prdTime) else { return }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute]
        formatter.zeroFormattingBehavior = .pad
        guard let predict = formatter.string(from: format2, to: format) else { return }
        
        if trDr == "1" {
            northbound.append(Arrivals(route: route, stopDes: stopDes, finalTime: predict, isApproch: isApproch, isDly: isDly, trDr: trDr))
        } else {
            southbound.append(Arrivals(route: route, stopDes: stopDes, finalTime: predict, isApproch: isApproch, isDly: isDly, trDr: trDr))
        }
        
        let flattenDirections = northbound.sorted(by: {$0.stopDes < $1.stopDes}) + southbound.sorted(by: {$0.stopDes < $1.stopDes})
        stationArrivals = flattenDirections
    }
    completion(stationArrivals, .none)
}

// MARK: - BUS JSON FUNCTIONS
// MARK: - Bus get routes from JSON
func getRoutes(completion: @escaping (_ busInfo: [Routes], _ error: NSError?) -> Void) {
    
    let feed = "http://www.ctabustracker.com/bustime/api/v2/getroutes?key=hQP7UKqGyevmsth9vGFX3LYhP&format=json"
    var busRoutes: [Routes] = []
    
    guard let url = URL(string: feed) else { return }
    
    guard let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode(BusRoot.self, from: data),
        let routes = task.bustimeResponse?.routes else { return }
    
    for item in routes {
        guard let rt = item.rt,
            let rtnm = item.rtnm,
            let rtclr = item.rtclr,
            let rtdd = item.rtdd else { return }
        
        busRoutes.append(Routes(rt: rt, rtnm: rtnm, rtclr: rtclr, rtdd: rtdd))
        busRoutes.sort(by: {$0.rtnm < $1.rtnm})
    }
    completion(busRoutes, .none)
}

// MARK: - Function to parse bus directions JSON
func getDirections(_ route: String, completion: @escaping (_ busInfo: [Directions], _ error: NSError?) -> Void) {
    
    let feed = "http://www.ctabustracker.com/bustime/api/v2/getdirections?key=hQP7UKqGyevmsth9vGFX3LYhP&rt=" + route + "&format=json"
    
    guard let url = URL(string: feed) else { return }
    var busDir: [Directions] = []
    
    guard let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode(BusRoot.self, from: data),
        let directionsArray = task.bustimeResponse?.directions else { return }
    
    for item in directionsArray {
        guard let dir = item.dir else { return }
        
        busDir.append(Directions(dir))
    }
    completion(busDir, .none)
}

// MARK: - Function to get bus stops JSON
func getStops(_ route: String, _ direction: String, completion: @escaping (_ busInfo: [Stops], _ error: NSError?) -> Void) {
    
    let feed = "http://www.ctabustracker.com/bustime/api/v2/getstops?key=hQP7UKqGyevmsth9vGFX3LYhP&rt=" + route + "&dir=" + direction + "&format=json"
    
    guard let url = URL(string: feed) else { return }
    var busStops: [Stops] = []
    
    guard let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode(BusRoot.self, from: data),
        let stopsArray = task.bustimeResponse?.stops else { return }
    
    for item in stopsArray {
        guard let stpid = item.stpid,
            let stpnm = item.stpnm else { return }
        
        busStops.append(Stops(stpid: stpid, stpnm: stpnm))
        busStops = busStops.sorted(by: {$0.stpnm < $1.stpnm})
    }
    completion(busStops, .none)
}

// MARK: - Function to get bus stop arrivals JSON
func getStopArrivals(_ route: String, _ stopId: String, completion: @escaping (_ busInfo: [ArrivalBusStops], _ error: NSError?) -> Void) {
    
    let feed = "http://ctabustracker.com/bustime/api/v2/getpredictions?key=hQP7UKqGyevmsth9vGFX3LYhP&rt=" + route + "&stpid=" + stopId + "&format=json"
    
    guard let url = URL(string: feed) else { return }
    var busArrivals: [ArrivalBusStops] = []
    
    guard let data = try? Data(contentsOf: url),
        let task = try? JSONDecoder().decode(BusRoot.self, from: data),
        let arrivalArray = task.bustimeResponse?.prd else { return }
    
    for item in arrivalArray {
        guard let rt = item.rt,
            let des = item.des,
            let prdctdn = item.prdctdn,
            let vid = item.vid else { return }
        
        busArrivals.append(ArrivalBusStops(rt: rt, des: des, prdctdn: prdctdn, vid: vid))
    }
    busArrivals = busArrivals.sorted(by: {$0.des < $1.des})
    completion(busArrivals, .none)
    
}

// MARK: - Structs for parsing Stations JSON
struct Station: Codable {
    let ada : Bool?
    let blue : Bool?
    let brn : Bool?
    let g : Bool?
    let map_id : String?
    let o : Bool?
    let p : Bool?
    let pnk : Bool?
    let red : Bool?
    let station_name : String?
    let stop_id : String?
    let y : Bool?
    
    private enum CodingKeys: String, CodingKey {
        case ada
        case blue
        case brn
        case g
        case map_id
        case o
        case p
        case pnk
        case red
        case station_name
        case stop_id
        case y
    }
}

// MARK: - Structs for parsing Arrival JSON
struct Root: Codable {
    let ctatt: Ctatt?
    
    enum CodingKeys: String, CodingKey {
        case ctatt
    }
}
struct Ctatt: Codable {
    let eta: [ETA]?
    
    private enum CodingKeys: String, CodingKey {
        case eta
    }
}

struct ETA: Codable {
    let staId: String?
    let stpId: String?
    let staNm: String?
    let stpDe: String?
    let rn: String?
    let rt: String?
    let destSt: String?
    let destNm: String?
    let trDr: String?
    let prdt: String?
    let arrT: String?
    let isApp: String?
    let isSch: String?
    let isDly: String?
    let isFlt: String?
    
    private enum CodingKeys: String, CodingKey {
        case staId
        case stpId
        case staNm
        case stpDe
        case rn
        case rt
        case destSt
        case destNm
        case trDr
        case prdt
        case arrT
        case isApp
        case isSch
        case isDly
        case isFlt
    }
}

// MARK: - Structs for Bus routes JSON
struct BusRoot: Codable {
    let bustimeResponse: BustimeResponse?
    
    private enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

struct BustimeResponse: Codable {
    let routes: [RoutesBus]?
    let directions: [DirectionsBus]?
    let stops: [StopsBus]?
    let prd: [PRD]?
    
    private enum CodingKeys: String, CodingKey {
        case routes
        case directions
        case stops
        case prd
    }
}

struct RoutesBus: Codable {
    let rt: String?
    let rtnm: String?
    let rtclr: String?
    let rtdd: String?
    
    private enum CodingKeys: String, CodingKey {
        case rt
        case rtnm
        case rtclr
        case rtdd
    }
}

// MARK: - Structs for Bus directions JSON
struct DirectionsBus: Codable {
    let dir: String?
    
    private enum CodingKeys: String, CodingKey {
        case dir
    }
}

// MARK: - Structs for bus stops JSON
struct StopsBus: Codable {
    let stpid: String?
    let stpnm: String?
    
    private enum CodingKeys: String, CodingKey {
        case stpid
        case stpnm
    }
}

// MARK: - Structs for bus arrival JSON
struct PRD: Codable {
    let rt: String?
    let des: String?
    let prdctdn: String?
    let vid: String?
    
    private enum CodingKeys: String, CodingKey {
        case rt
        case des
        case prdctdn
        case vid
    }
}

// MARK: - Removes duplicates in a array
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
















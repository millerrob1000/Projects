//
//  AppDelegate.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/22/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            if WCSession.isSupported() {
                let session = WCSession.default
                session.delegate = self
                session.activate()
            }
        
        if UserDefaults.standard.object(forKey: "favorites") != nil {
            retrieveItems()
        }
        // MARK: - Register defaults for boolean checks to later set
        UserDefaults.standard.register(defaults: ["swipeDirections": false])
        UserDefaults.standard.register(defaults: ["favDirections": false])
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    @nonobjc func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("ready to talk to watch")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WC Session did become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WC Session did deactivate")
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String:Any], replyHandler: @escaping ([String:Any]) -> Void) {
        let value = message["request"] as? String
        if value != nil {
            getStations(value!, completion: { railStations, Error in
                let sendStations: [Stations] = railStations
                NSKeyedArchiver.setClassName("Stations", for: Stations.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: sendStations)
                replyHandler(["reply":encoded])
            })
        }
        
        let arrive = message["arrivals"] as? String
        if arrive != nil {
            getArrivals(arrive!, completion: { railArrivals, Error in
                let sendArrivals: [Arrivals] = railArrivals
                NSKeyedArchiver.setClassName("Arrivals", for: Arrivals.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: sendArrivals)
                replyHandler(["arrivalsReply":encoded])
                })
            }
        let routes = message["busRoute"] as? String
        if routes != nil {
            getRoutes(completion: { busRoutes, Error in
                let sendRoutes: [Routes] = busRoutes
                NSKeyedArchiver.setClassName("Routes", for: Routes.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: sendRoutes)
                replyHandler(["busRouteReply":encoded])
                })
            }
        let direct = message["directions"] as? String
        if direct != nil {
            getDirections(direct!, completion: { busDirections, Error in
                let sendDirect: [Directions] = busDirections
                NSKeyedArchiver.setClassName("Directions", for: Directions.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: sendDirect)
                replyHandler(["directionsReply":encoded])
            })
        }
        let stop = message["stops"] as? [String]
        if stop != nil {
            getStops(stop![0], stop![1], completion: { busStops, Error in
                let sendStops: [Stops] = busStops
                NSKeyedArchiver.setClassName("Stops", for: Stops.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: sendStops)
                replyHandler(["stopsReply":encoded])
            })
        }
        let busArrival = message["busArrivals"] as? [String]
        if busArrival != nil {
            getStopArrivals(busArrival![0], busArrival![1], completion: { busArrivals, Error in
                let sendArrivals: [ArrivalBusStops] = busArrivals
                NSKeyedArchiver.setClassName("ArrivalBusStops", for: ArrivalBusStops.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: sendArrivals)
                replyHandler(["busArrivalsReply":encoded])
            })
        }
        let getUpdates = message["alerts"] as? String
        if getUpdates != nil {
            getStationUpdates(FavoritesViewController.shared.favArray, completion: { alertArray, Error in
                let alerts = alertArray
                NSKeyedArchiver.setClassName("AlertObject", for: AlertObject.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: alerts)
                replyHandler(["alertsReply":encoded])
            })
 
        }
        let getFavs = message["favoritesWatch"] as? String
        if getFavs != nil {
                NSKeyedArchiver.setClassName("Stations", for: Stations.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: FavoritesViewController.shared.favArray)
                replyHandler(["favWatchReply":encoded])
        }
    }
}


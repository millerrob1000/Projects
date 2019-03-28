//
//  AppDelegate.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/22/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit
import WatchConnectivity
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            if WCSession.isSupported() {
                let session = WCSession.default
                session.delegate = self
                session.activate()
            }
        
        if UserDefaults.standard.object(forKey: "favorites") != nil {
            retrieveItems()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @nonobjc func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.registerForRemoteNotifications()
        return true
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString: String?
        // Convert token to string
        if deviceToken.reduce("", {$0 + String(format: "%02X", $1)}) != UserDefaults.standard.string(forKey: "Notification") {
            deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        }else{
            deviceTokenString = UserDefaults.standard.string(forKey: "Notification")
        }
        
        // Print it to console
        print("APNs device token: \(String(describing: deviceTokenString))")
        
        // Persist it in your backend in case it's new
        UserDefaults.standard.set(deviceTokenString, forKey: "Notification")
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
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
            getStationUpdates(railInfo.favArray, completion: { alertArray, Error in
                let alerts = alertArray
                NSKeyedArchiver.setClassName("AlertObject", for: AlertObject.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: alerts)
                replyHandler(["alertsReply":encoded])
            })
        }
        let getFavs = message["favoritesWatch"] as? String
        if getFavs != nil {
                NSKeyedArchiver.setClassName("Stations", for: Stations.self)
                let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: railInfo.favArray)
                replyHandler(["favWatchReply":encoded])
        }
    }
}


//
//  MainInterfaceController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/8/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit
import WatchConnectivity
import UserNotifications


class MainInterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {
    
    @IBOutlet var ctaAlerts: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        UNUserNotificationCenter.current().delegate = self
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        WatchData.favArray = [Stations]()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func checkCTAalerts() {
        WKInterfaceDevice.current().play(.click)
        ctaAlerts.setTitle("Retrieving Data...")
        
        WCSession.default.sendMessage(["alerts": "sendAlerts"], replyHandler: { (reply: [String:Any]) -> Void in
            let value = reply["alertsReply"] as? Data
            print(value as Any)
            if value != nil {
                NSKeyedUnarchiver.setClass(AlertObject.self, forClassName: "AlertObject")
                let decoded = NSKeyedUnarchiver.unarchiveObject(with: value!)
                let alertList = decoded as! [AlertObject]
                self.sendNotifications(alertList)
            }
            self.ctaAlerts.setTitle("Check CTA Alerts")
            }, errorHandler: { error in
                print(error.localizedDescription)
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func sendNotifications(_ array: [AlertObject]){
        DispatchQueue.main.async {
        if array.isEmpty {
            let action = WKAlertAction(title: "OK", style: .cancel, handler: {print("ok")})
            self.presentAlert(withTitle: "NO CTA ALERTS", message: "There are no CTA alerts for the stations or bus stops in your favorites list", preferredStyle: .alert, actions: [action])
            }
        }
        
        let content = UNMutableNotificationContent()
            for i in array {
                content.title = i.serviceName
                content.subtitle = i.impact
                content.body = i.shortDes
                content.sound = UNNotificationSound.default
            
                let uuid = UUID().uuidString
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {(error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }else{
                        print("message sent")
                    }
                })
            }
        }
    }

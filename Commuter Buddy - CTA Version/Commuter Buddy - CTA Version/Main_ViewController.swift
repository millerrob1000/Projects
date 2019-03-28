//
//  Main_ViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/22/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit
import UserNotifications

class Main_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var railLines: UITableView!
    var timer: Timer?
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        railLines.delegate = self
        railLines.dataSource = self
        UNUserNotificationCenter.current().delegate = self
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
                
        self.view.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 121/255.0, blue: 194/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = "Commuter Buddy"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return railInfo.trains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        railLines.backgroundColor = UIColor.black
        
        let cell = railLines.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let color = railInfo.trains[indexPath.row].type.rawValue
        cell.backgroundColor = getColor(color)
        cell.accessoryType = .disclosureIndicator
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.clipsToBounds = true
        
        cell.textLabel!.text = railInfo.trains[indexPath.row].name
        cell.detailTextLabel!.text = railInfo.trains[indexPath.row].routes
        
        if(railInfo.trains[indexPath.row].type.rawValue == "y"){
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        }else{
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }
        return cell
    }
    
    @IBAction func checkCTAalerts(_ sender: UIButton) {
        if railInfo.favArray.isEmpty {
            let alertController = UIAlertController(title: "FAVORITES LIST IS EMPTY", message: "Add train stations or bus stops to receive alerts", preferredStyle: UIAlertControllerStyle.alert)
            let confirm = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(confirm)
            self.present(alertController, animated: true, completion: nil)
        }
        
        var alertsList: [AlertObject] = []
        getStationUpdates(railInfo.favArray, completion: { alertArray, Error in
            alertsList = alertArray
        })
        
        if alertsList.isEmpty {
            let alertController = UIAlertController(title: "NO CTA ALERTS", message: "There are no CTA alerts for the stations or bus stops in your favorites list", preferredStyle: UIAlertControllerStyle.alert)
            let confirm = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(confirm)
            self.present(alertController, animated: true, completion: nil)
        }else{
        sendNotifications(alertsList)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func sendNotifications(_ array: [AlertObject]){
        let content = UNMutableNotificationContent()
        DispatchQueue.global(qos: .background).async {
        for i in array {
            content.title = i.serviceName
            content.subtitle = i.impact
            content.body = i.shortDes
            content.sound = UNNotificationSound.default()
            self.counter += 1
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                UIApplication.shared.applicationIconBadgeNumber = array.count
            }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? StationsViewController {
            let index = railLines.indexPathForSelectedRow?.row
            target.railName = railInfo.trains[index!].name
            target.railType = railInfo.trains[index!].type.rawValue
        }
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}

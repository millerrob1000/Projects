//
//  ArrivalStopsTableViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class ArrivalStopsTableViewController: UITableViewController {
    
    @IBOutlet var noItemsView: UIView!
    @IBOutlet var arrivalBusTable: UITableView!
    var route: String?
    var stopId: String?
    var stopName: String?
    var color: UIColor?
    var timer: Timer?
    private var arrivalList = [ArrivalBusStops]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set up navigation controller look
        title = "\(stopName!) Arrivals"
        view.backgroundColor = UIColor.black
        arrivalBusTable.backgroundColor = UIColor.black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Bus Routes", style: .done, target: self, action: #selector(mainScreen))
        
        // MARK: - Get bus stops
        getStopArrivals(route!, stopId!, completion: { busInfo, Error in
            self.arrivalList = busInfo
        })
        
        // MARK: - Calls view if array of stops is empty
        noItemsView.center = self.view.center
        if arrivalList.isEmpty {
            arrivalBusTable.backgroundView = noItemsView
        }
    }
    
    // MARK: - Timer to reload arrivals
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
    }
    
    // MARK: - Turns off timer
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @objc func loadData() {
        getStopArrivals(route!, stopId!, completion: { busInfo, Error in
            self.arrivalList = busInfo
        })
        self.arrivalBusTable.reloadData()
    }
    
    // MARK: - Tableview delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivalList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = arrivalBusTable.dequeueReusableCell(withIdentifier: "arrivalStops", for: indexPath) as! StopsTableViewCell
        cell.backgroundColor = color
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        cell.routeLabel.text = arrivalList[indexPath.row].rt
        cell.desLabel.text = "To \(arrivalList[indexPath.row].des)"
        if arrivalList[indexPath.row].prdctdn == "DUE" {
            cell.timeLabel.text = arrivalList[indexPath.row].prdctdn
        }else{
            cell.timeLabel.text = "\(arrivalList[indexPath.row].prdctdn) MINS"
        }
        cell.busIdLabel.text = arrivalList[indexPath.row].vid
        
        return cell
    }
}

// MARK: - Utility function
extension ArrivalStopsTableViewController {
    
    @objc func mainScreen(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindBus", sender: self)
    }
}

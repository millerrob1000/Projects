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
    var arrivalList = [ArrivalBusStops]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(stopName!) Arrivals"
        self.view.backgroundColor = UIColor.black
        self.arrivalBusTable.backgroundColor = UIColor.black
        
        getStopArrivals(route!, stopId!, completion: { busInfo, Error in
            self.arrivalList = busInfo
        })
        
        noItemsView.center = self.view.center
        if arrivalList.isEmpty {
            arrivalBusTable.backgroundView = noItemsView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func loadData() {
        getStopArrivals(route!, stopId!, completion: { busInfo, Error in
            self.arrivalList = busInfo
        })
        self.arrivalBusTable.reloadData()
    }

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
        cell.clipsToBounds = true
        
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

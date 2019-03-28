//
//  StopsTableViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class StopsTableViewController: UITableViewController {
    
    var route: String?
    var direction: String?
    var name: String?
    var color: UIColor?
    var stopList = [Stops]()
    
    @IBOutlet var stopsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        self.stopsTable.backgroundColor = UIColor.black
        self.title = "\(name!) \(direction!)"
        
        getStops(route!, direction!, completion: { busInfo, Error in
            self.stopList = busInfo
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stopsTable.dequeueReusableCell(withIdentifier: "stops", for: indexPath)
        cell.backgroundColor = color
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.clipsToBounds = true
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = stopList[indexPath.row].stpnm
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Add to Favorites") { (rowAction, indexPath) in
            if !railInfo.favArray.contains(where: {$0.stpid == self.stopList[indexPath.row].stpid}){
                railInfo.favArray.append(Stations("","","",self.stopList[indexPath.row].stpid, self.stopList[indexPath.row].stpnm, self.color!, self.route!))
                insertItems()
                let alertController = UIAlertController(title: "ADDED TO FAVORITES LIST", message: "\(self.stopList[indexPath.row].stpnm) stop has been successfully added", preferredStyle: UIAlertControllerStyle.alert)
                let confirm = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(confirm)
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "UNABLE TO ADD TO FAVORITES LIST", message: "\(self.stopList[indexPath.row].stpnm) stop has already been added", preferredStyle: UIAlertControllerStyle.alert)
                let confirm = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(confirm)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        editAction.backgroundColor = UIColor(red: 255/255.0, green: 147/255.0, blue: 0/255.0, alpha: 0.7)
        return [editAction]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? ArrivalStopsTableViewController {
            let index = stopsTable.indexPathForSelectedRow?.row
            target.stopId = stopList[index!].stpid
            target.stopName = stopList[index!].stpnm
            target.route = self.route!
            target.color = self.color
            navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: DirectionsTableViewController.self, action: nil)
        }
    }
    

}

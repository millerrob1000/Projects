//
//  RoutesTableViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class RoutesTableViewController: UITableViewController {

    @IBOutlet var busRoutes: UITableView!
    var routesList: [Routes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set up navigation controller look
        view.backgroundColor = UIColor.black
        busRoutes.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 121/255.0, blue: 194/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = "CTA Bus Routes"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // MARK: - Get bus routes
        getRoutes(completion: { busInfo, Error in
            self.routesList = busInfo
        })
    }
    
    // MARK: - Unwind function
    @IBAction func unwindBus(segue: UIStoryboardSegue) { }

    // MARK: - Tableview delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = busRoutes.dequeueReusableCell(withIdentifier: "routes", for: indexPath)
        cell.backgroundColor = routesList[indexPath.row].rtclr
        cell.accessoryType = .disclosureIndicator
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        cell.textLabel?.text = routesList[indexPath.row].rtnm
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? DirectionsTableViewController {
            let index = busRoutes.indexPathForSelectedRow?.row
            target.route = routesList[index!].rt
            target.color = routesList[index!].rtclr
            target.name = routesList[index!].rtnm
            navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: DirectionsTableViewController.self, action: nil)
        }
    }
}

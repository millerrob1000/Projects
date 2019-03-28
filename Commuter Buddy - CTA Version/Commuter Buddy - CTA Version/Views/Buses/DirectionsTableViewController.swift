//
//  DirectionsTableViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 12/7/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class DirectionsTableViewController: UITableViewController {
    
    var route: String?
    var color: UIColor?
    var name: String?
    private var directionsList = [Directions]()
    
    @IBOutlet var directTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        directTable.backgroundColor = UIColor.black
        
        title = "\(name!) Directions"
        
        // MARK: - Get bus directions
        getDirections(route!, completion: { busInfo, Error in
            self.directionsList = busInfo
        })
    }
    
    // MARK: - Tableview delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return directionsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = directTable.dequeueReusableCell(withIdentifier: "directions", for: indexPath)
        cell.backgroundColor = color
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.accessoryType = .disclosureIndicator
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        cell.textLabel?.text = directionsList[indexPath.row].dir
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? StopsTableViewController {
            let index = directTable.indexPathForSelectedRow?.row
            target.direction = directionsList[index!].dir
            target.route = self.route
            target.name = self.name
            target.color = self.color
            navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: DirectionsTableViewController.self, action: nil)
        }
    }
}

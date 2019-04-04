//
//  StationsViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/23/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var railStations: [Stations] = []
    var railName: String?
    var railType: String?
    
    @IBOutlet weak var stationList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeDirections()
        
        // MARK: - Set up tableview delegates
        stationList.delegate = self
        stationList.dataSource = self
        
        // MARK: - Set up background colors
        view.backgroundColor = UIColor.black
        stationList.backgroundColor = UIColor.black
        
        // MARK: - Set up navigation controller look
        title = railName! + " Line Stations"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        // MARK: - Get stations from CTA
        getStations(railType!, completion: {railStations, Error in
            self.railStations = railStations
        })
    }
    
    // MARK: - Tableview delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if railStations.count > 0 {
            self.stationList.backgroundView = nil
            count = 1
        }else{
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.stationList.bounds.size.width, height: self.stationList.bounds.size.height))
            noDataLabel.text = "NO CTA DATA AVAILABLE AT THIS TIME"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.stationList.backgroundView = noDataLabel
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return railStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationList.dequeueReusableCell(withIdentifier: "stations", for: indexPath)
        let color = railType
        cell.backgroundColor = getColor(color!)
        cell.accessoryType = .disclosureIndicator
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        cell.textLabel?.text = railStations[indexPath.row].name
        
        if(color == "y"){
            cell.textLabel?.textColor = UIColor.black
        }else{
            cell.textLabel?.textColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Add to Favorites") { (rowAction, indexPath) in
            
            if !railInfo.favArray.contains(where: {$0.name == self.railStations[indexPath.row].name && $0.type == self.railStations[indexPath.row].type}) {
                
                let alertController = UIAlertController(title: "ADDED TO FAVORITES LIST", message: "\(self.railStations[indexPath.row].name) station has been successfully added", preferredStyle: UIAlertController.Style.actionSheet)
                let confirm = UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    // MARK: - Observer creation for favorites list
                    let favData: Stations = Stations(self.railStations[indexPath.row].name, self.railStations[indexPath.row].mapID, self.railStations[indexPath.row].type)
                    if !railInfo.favArray.contains(favData) {
                        railInfo.favArray.append(favData)
                        insertItems()
                    }
                })
                let cancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
                
                alertController.addAction(confirm)
                alertController.addAction(cancel)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "UNABLE TO ADD TO FAVORITES LIST", message: "\(self.railStations[indexPath.row].name) station has already been added", preferredStyle: UIAlertController.Style.actionSheet)
                let confirm = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(confirm)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        editAction.backgroundColor = UIColor(red: 255/255.0, green: 147/255.0, blue: 0/255.0, alpha: 0.7)
        return [editAction]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? ArrivalsViewController {
            let index = stationList.indexPathForSelectedRow?.row
            target.stationName = railStations[index!].name
            target.railMapID = railStations[index!].mapID
        }
    }
}

// MARK: - Utility functions
extension StationsViewController {
    func swipeDirections() {
        if !UserDefaults.standard.bool(forKey: "swipeDirections") {
            let alert = UIAlertController(title: "How to add stations to your favorites list", message: "Swipe any row to the left and press \"Add to favorites\"", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "swipeDirections")
        }
    }
}

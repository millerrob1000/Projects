//
//  Main_ViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Max OSX on 11/22/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class Main_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var railLines: UITableView!
    
    private var timer: Timer?
    private var counter = 0
    private var alertsList: [AlertObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationButton.roundCorners(radius: 20, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        
        // MARK: - Set up tableview delegates
        railLines.delegate = self
        railLines.dataSource = self
        
        // MARK: - Set up navigation controller look
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 121/255.0, blue: 194/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = "Commuter Buddy"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
//        var tableViewHeight: CGFloat {
//            railLines.layoutIfNeeded()
//            return railLines.contentSize.height - notificationButton.bounds.height
//        }
//
//        railLines.rowHeight = tableViewHeight / 7.25
        
        railLines.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Unwind function
    @IBAction func unwindTrain(segue: UIStoryboardSegue) { }
    
    // MARK: - Tableview delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.bounds.height - notificationButton.bounds.height / 8
//    }
    
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
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? StationsViewController {
            let index = railLines.indexPathForSelectedRow?.row
            target.railName = railInfo.trains[index!].name
            target.railType = railInfo.trains[index!].type.rawValue
        }
    }
}

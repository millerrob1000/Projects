//
//  AlertsTableViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Miller III, Rob on 8/21/18.
//  Copyright © 2018 Max OSX. All rights reserved.
//

import UIKit

class AlertsTableViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var alertsArray: [AlertObject] = [AlertObject]()
    private let showAsPopoverOnPhone = true
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set up navigation controller
        view.backgroundColor = UIColor.black
        navBar.barTintColor = UIColor(red: 0/255.0, green: 121/255.0, blue: 194/255.0, alpha: 1.0)
        navBar.tintColor = UIColor.white
        navBarTitle.title = "CTA Alerts"
        navBarButton.title = "Close"
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: - Get CTA alerts
        getStationUpdates(railInfo.favArray, completion: { alertArray, Error in
            self.alertsArray = alertArray
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Class init for popover
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        if showAsPopoverOnPhone {
            self.modalPresentationStyle = .popover
            self.popoverPresentationController?.delegate = self
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Tableview delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var count = 0
        
        if alertsArray.count > 0 {
            tableView.backgroundView = nil
            count = 1
        } else if railInfo.favArray.isEmpty {
            tableviewMessage(message: "FAVORITES LIST IS EMPTY\nAdd train stations or bus stops to receive alerts")
        }else if alertsArray.isEmpty {
            tableviewMessage(message: "NO CTA ALERTS\nThere are no CTA alerts for the stations or bus stops in your favorites list")
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alertsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ctaalerts", for: indexPath)
        
        cell.backgroundColor = alertsArray[indexPath.row].serviceBackColor
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.clipsToBounds = true
        cell.isUserInteractionEnabled = false
        
        cell.textLabel?.text = alertsArray[indexPath.row].serviceName
        cell.detailTextLabel?.text = alertsArray[indexPath.row].shortDes
        if alertsArray[indexPath.row].serviceId.lowercased() == "y" {
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        } else {
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }
        
        return cell
    }
}

extension AlertsTableViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Utility Functions
extension AlertsTableViewController {
    
    private func tableviewMessage(message: String) {
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = message
        noDataLabel.numberOfLines = 10
        noDataLabel.textColor = UIColor.white
        noDataLabel.textAlignment = NSTextAlignment.center
        tableView.backgroundView = noDataLabel
        tableView.separatorColor = UIColor.clear
    }
}

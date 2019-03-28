//
//  AlertsViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob Miller on 3/17/19.
//  Copyright © 2019 Max OSX. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var alertsArray: [AlertObject] = [AlertObject]()
    private let showAsPopoverOnPhone = true
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - Set up navigation controller
        view.backgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        navBar.barTintColor = UIColor(red: 0/255.0, green: 121/255.0, blue: 194/255.0, alpha: 1.0)
        navBar.tintColor = UIColor.white
        navBarTitle.title = "CTA Alerts"
        navBarButton.title = "Close"
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: - Get CTA alerts
        getStationUpdates(FavoritesViewController.shared.favArray, completion: { alertArray, Error in
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
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if alertsArray.count > 0 {
            tableView.backgroundView = nil
            count = 1
        } else if FavoritesViewController.shared.favArray.isEmpty {
            tableviewMessage(message: "FAVORITES LIST IS EMPTY\nAdd train stations or bus stops to receive alerts")
        }else if alertsArray.isEmpty {
            tableviewMessage(message: "NO CTA ALERTS\nThere are no CTA alerts for the stations or bus stops in your favorites list")
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ctaalerts", for: indexPath)
        
        cell.backgroundColor = alertsArray[indexPath.row].serviceBackColor
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
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

extension AlertsViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Utility Functions
extension AlertsViewController {
    
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

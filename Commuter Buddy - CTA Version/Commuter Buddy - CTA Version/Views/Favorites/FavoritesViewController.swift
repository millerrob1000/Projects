//
//  FavoritesViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/26/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favList: UITableView!
    @IBOutlet var noItemsView: UIView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet var noItemViewLandscape: UIView!
    @IBOutlet weak var viewLabelLandscape: UILabel!
    static let shared: FavoritesViewController = FavoritesViewController()
    var favArray: [Stations] = [Stations]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set up delegates for tableview
        favList.delegate = self
        favList.dataSource = self
        
        // MARK: - View that displays message
        noItemsView.center = self.view.center
        noItemViewLandscape.center = self.view.center
        viewLabel.text = "You don't have any favorite stations yet. Slide a station or bus stop row to the left to add"
        viewLabelLandscape.text = "You don't have any favorite stations yet. Slide a station or bus stop row to the left to add"
        
        
        istheArrayEmpty()
        
        // MARK: - Set up navigation controller look
        self.view.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 121/255.0, blue: 194/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = "Favorite CTA Stations/Stops List"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        istheArrayEmpty()
        
        // MARK: - Observer for added favorites
        NotificationCenter.default.addObserver(self, selector: #selector(addFavorite), name: NSNotification.Name(rawValue: "favorite"), object: nil)
        
        favList.reloadData()
        
        if !FavoritesViewController.shared.favArray.isEmpty {
            swipeDirections()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Observer function
    @objc func addFavorite(_ notification: NSNotification) {
        if let addedFavorite = notification.userInfo?["favorite"] as? Stations {
            if !FavoritesViewController.shared.favArray.contains(addedFavorite) {
            FavoritesViewController.shared.favArray.append(addedFavorite)
            insertItems()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //make sure to only activate when on this viewcontroller
        guard tabBarController?.selectedIndex == 2 else { return }
        
        if FavoritesViewController.shared.favArray.isEmpty {
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                favList.backgroundView = noItemsView
                break
            case .landscapeLeft, .landscapeRight:
                favList.backgroundView = noItemViewLandscape
                break
            default:
                break
            }
        }
    }
    
    // MARK: - Checks orientation and sets the correct view
    func istheArrayEmpty() {
        if FavoritesViewController.shared.favArray.isEmpty {
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                favList.backgroundView = noItemsView
                break
            case .landscapeLeft, .landscapeRight:
                favList.backgroundView = noItemViewLandscape
                break
            default:
                favList.backgroundView = noItemsView
            }
        }
    }
    
    // MARK: - Tableview delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfsections = 0
        
        if FavoritesViewController.shared.favArray.count > 0 {
            self.favList.backgroundView = nil
            numOfsections = 1
        }
        return numOfsections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesViewController.shared.favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        favList.backgroundColor = UIColor.black
        
        let cell = favList.dequeueReusableCell(withIdentifier: "favorite", for: indexPath)
        
        let color = FavoritesViewController.shared.favArray[indexPath.row].type
        
        if color != "" {
            cell.backgroundColor = getColor(color)
        }else{
            cell.backgroundColor = FavoritesViewController.shared.favArray[indexPath.row].stopColor
        }
        cell.accessoryType = .disclosureIndicator
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        if FavoritesViewController.shared.favArray[indexPath.row].name != "" {
            cell.textLabel?.text = FavoritesViewController.shared.favArray[indexPath.row].name
            cell.textLabel?.textColor = UIColor.white
        }else{
            cell.textLabel?.text = FavoritesViewController.shared.favArray[indexPath.row].stpnm
            cell.textLabel?.textColor = UIColor.black
        }
        
        if(color == "y"){
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            var temp = ""
            
            if FavoritesViewController.shared.favArray[indexPath.row].name != "" {
                temp = "\(FavoritesViewController.shared.favArray[indexPath.row].name) station"
            }else{
                temp = "\(FavoritesViewController.shared.favArray[indexPath.row].stpnm) stop"
            }
            
            let alertController = UIAlertController(title: "REMOVAL FROM FAVORITES LIST", message: "\(temp) has been successfully removed", preferredStyle: UIAlertController.Style.actionSheet)
            
            let confirm = UIAlertAction(title: "OK", style: .default, handler: { action in
                UserDefaults.standard.removeObject(forKey: "favorites")
                FavoritesViewController.shared.favArray.remove(at: indexPath.row)
                self.istheArrayEmpty()
                insertItems()
                self.favList.reloadData()
            })
            let cancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
            
            alertController.addAction(confirm)
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch FavoritesViewController.shared.favArray[indexPath.row].name {
        case "":
            performSegue(withIdentifier: "bus", sender: self)
            break
        default:
            performSegue(withIdentifier: "train", sender: self)
            break
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = favList.indexPathForSelectedRow?.row else { return }
        
        if FavoritesViewController.shared.favArray[index].name != "" {
            if let target = segue.destination as? ArrivalsViewController {
                target.stationName = FavoritesViewController.shared.favArray[index].name
                target.railMapID = FavoritesViewController.shared.favArray[index].mapID
                navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: ArrivalsViewController.self, action: nil)
            }
        }else if FavoritesViewController.shared.favArray[index].name == "" {
            if let target = segue.destination as? ArrivalStopsTableViewController {
                target.stopId = FavoritesViewController.shared.favArray[index].stpid
                target.color = FavoritesViewController.shared.favArray[index].stopColor
                target.route = FavoritesViewController.shared.favArray[index].route
                target.stopName = FavoritesViewController.shared.favArray[index].stpnm
                navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: ArrivalStopsTableViewController.self, action: nil)
            }
        }
    }
}

// MARK: - Utility function
extension FavoritesViewController {
    func swipeDirections() {
        if !UserDefaults.standard.bool(forKey: "favDirections") {
            let alert = UIAlertController(title: "How to remove items from your favorites list", message: "Swipe any row to the left and press \"Delete\"", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "favDirections")
        }
    }
}

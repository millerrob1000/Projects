//
//  ArrivalsViewController.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/24/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import UIKit

class ArrivalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var arrivalsList: UITableView!
    
    private var timer: Timer?
    private let sectionHeaderHeight: CGFloat = 40
    //Data variable to track sorted data
    private var data = [TableSection: [[String: String]]]()
    private var northbound: [Arrivals] = [Arrivals]()
    private var southbound: [Arrivals] = [Arrivals]()
    private var trainDirectionsSections: [[Arrivals]] = [[Arrivals]]()
    var stationName: String?
    var railMapID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set up tableview delegates and background color
        arrivalsList.delegate = self
        arrivalsList.dataSource = self
        arrivalsList.backgroundColor = UIColor.black
        arrivalsList.sectionHeaderHeight = 30
        
        // MARK: - Set up navigation controller look
        title = stationName! + " Arrivals"
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Train Lines", style: .plain, target: self, action: #selector(mainScreen))
        
        // MARK: - Get CTA arrivals
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Refreshes the tableview to see updated CTA information
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loadData), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    // MARK: - Tableview delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if trainDirectionsSections.count > 0 {
            self.arrivalsList.backgroundView = nil
            count = TableSection.total.rawValue
        }else{
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.arrivalsList.bounds.size.width, height: self.arrivalsList.bounds.size.height))
            noDataLabel.text = "NO CTA DATA AVAILABLE AT THIS TIME"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.arrivalsList.backgroundView = noDataLabel
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainDirectionsSections[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: sectionHeaderHeight))
        view.backgroundColor = UIColor.black
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width, height: sectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: label.bounds.height - 10)
        label.textColor = UIColor.white
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .northbound:
                label.text = "Northbound Trains"
            case .southbound:
                label.text = "Southbound Trains"
            default:
                label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = self.arrivalsList.dequeueReusableCell(withIdentifier: "arrivals", for: indexPath) as! CustomTableViewCell

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = getColorArrivals(trainDirectionsSections[indexPath.section][indexPath.row].route)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        cell.mainLabel.text = trainDirectionsSections[indexPath.section][indexPath.row].stopDes
        
        if trainDirectionsSections[indexPath.section][indexPath.row].isApproch == "1" {
            cell.timeLabel.text = "DUE"
        }else if trainDirectionsSections[indexPath.section][indexPath.row].isDly == "1" {
            cell.timeLabel.text = "DELAYED"
        }else if trainDirectionsSections[indexPath.section][indexPath.row].isApproch == "0" || trainDirectionsSections[indexPath.section][indexPath.row].isDly == "0" {
            cell.timeLabel.text = trainDirectionsSections[indexPath.section][indexPath.row].finalTime + " mins"
        }
        if trainDirectionsSections[indexPath.section][indexPath.row].route == "Y" {
            cell.mainLabel.textColor = UIColor.black
            cell.timeLabel.textColor = UIColor.black
        }else{
            cell.mainLabel.textColor = UIColor.white
            cell.timeLabel.textColor = UIColor.white
        }
        return cell
    }
}

// MARK: - Utility functions
extension ArrivalsViewController {
    
    @objc func loadData() {
        guard let railmap = railMapID else { return }
        
        northbound = [Arrivals]()
        southbound = [Arrivals]()
        trainDirectionsSections = [[Arrivals]]()
        
        getArrivals(railmap, completion: {arrivals, Error in
            for item in arrivals {
                if item.trDr == "1" {
                    self.northbound.append(item)
                } else {
                    self.southbound.append(item)
                }
            }
            self.northbound.sort(by: {$0.stopDes < $1.stopDes})
            self.southbound.sort(by: {$0.stopDes < $1.stopDes})
            self.trainDirectionsSections.append(self.northbound)
            self.trainDirectionsSections.append(self.southbound)
        })
        arrivalsList.reloadData()
    }
    
    @objc func mainScreen(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindTrain", sender: self)
    }
    
    // MARK: - Enum for sections
    enum TableSection: Int {
        case northbound = 0, southbound, total
    }
}

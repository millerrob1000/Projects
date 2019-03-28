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
    var arrivalStations = [Arrivals]()
    var timer: Timer?
    var stationName: String?
    var railMapID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrivalsList.delegate = self
        arrivalsList.dataSource = self
        
        self.title = stationName! + " Arrivals"
        self.view.backgroundColor = UIColor.black
        arrivalsList.backgroundColor = UIColor.black
        self.arrivalsList.sectionHeaderHeight = 30
        
        getArrivals(railMapID!, completion: {arrivals, Error in
            self.arrivalStations = arrivals
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @objc func loadData() {
        getArrivals(railMapID!, completion: {arrivals, Error in
            self.arrivalStations = arrivals
        })
        self.arrivalsList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if arrivalStations.count > 0 {
            self.arrivalsList.backgroundView = nil
            count = 1
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
        return arrivalStations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = self.arrivalsList.dequeueReusableCell(withIdentifier: "arrivals", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = getColorArrivals(arrivalStations[indexPath.row].route)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.clipsToBounds = true
        cell.mainLabel.text = arrivalStations[indexPath.row].stopDes
        
        if arrivalStations[indexPath.row].isApproch == "1" {
            cell.timeLabel.text = "DUE"
        }else if arrivalStations[indexPath.row].isDly == "1" {
            cell.timeLabel.text = "DELAYED"
        }else if arrivalStations[indexPath.row].isApproch == "0" || arrivalStations[indexPath.row].isDly == "0" {
            cell.timeLabel.text = arrivalStations[indexPath.row].finalTime + " mins"
        }
        if arrivalStations[indexPath.row].route == "Y" {
            cell.mainLabel.textColor = UIColor.black
            cell.timeLabel.textColor = UIColor.black
        }else{
            cell.mainLabel.textColor = UIColor.white
            cell.timeLabel.textColor = UIColor.white
        }
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

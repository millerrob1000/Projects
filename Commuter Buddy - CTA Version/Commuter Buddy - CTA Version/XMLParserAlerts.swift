//
//  XMLParserAlerts.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/28/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash

struct Alert: XMLIndexerDeserializable {
    let AlertId: String
    let Headline: String
    let ShortDescription: String
    let Impact: String
    let ServiceName: String
    let ServiceID: String
    
    static func deserialize(_ node: XMLIndexer) throws -> Alert {
        return try Alert(
            AlertId: node["AlertId"].value(),
            Headline: node["Headline"].value(),
            ShortDescription: node["ShortDescription"].value(),
            Impact: node["Impact"].value(),
            ServiceName: node["ImpactedService"]["Service"][0]["ServiceName"].value(),
            ServiceID: node["ImpactedService"]["Service"][0]["ServiceId"].value())
    }
}

func getStationUpdates(_ favArray: [Stations], completion: @escaping (_ stationAlerts: [AlertObject], _ error: NSError?) -> Void) {
    let feed = "http://www.transitchicago.com/api/1.0/alerts.aspx"
    guard let url = URL(string: feed) else { return }
    
   do{
    let data = try Data(contentsOf: url)
    let xml = SWXMLHash.parse(data)
    let alert: [Alert] = try xml["CTAAlerts"]["Alert"].value()
    
    var alerts: [AlertObject] = []
    
    for i in alert {
        for j in favArray {
        if i.ServiceID == j.route {
                alerts.append(AlertObject(i.AlertId, i.Headline, i.ShortDescription, i.Impact, i.ServiceName, i.ServiceID))
            }
            else if i.ServiceID == getTypeAlerts(j.type) {
                alerts.append(AlertObject(i.AlertId, i.Headline, i.ShortDescription, i.Impact, i.ServiceName, i.ServiceID))
            }
        }
    }
    completion(alerts, .none)
    
    }catch let error as NSError {
        print(error.localizedDescription)
        completion([], error)
    }
}

//
//  XMLParserAlerts.swift
//  Commuter Buddy - CTA Version
//
//  Created by Rob on 11/28/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Function for parsing XML CTA alerts
func getStationUpdates(_ favArray: [Stations], completion: @escaping (_ stationAlerts: [AlertObject], _ error: NSError?) -> Void) {
    let feed = "http://www.transitchicago.com/api/1.0/alerts.aspx"
     var alerts: [AlertObject] = []
    
    guard let url = URL(string: feed) else { return }
    
    guard let data = try? Data(contentsOf: url),
        let task = try? XMLDecoder().decode(CTAAlerts.self, from: data),
        let alertArray = task.alert else { return }
    
    for item in alertArray {
        guard let alertId = item.alertId,
            let headline = item.headline,
            let shortDescription = item.shortDescription,
            let impact = item.impact,
            let serviceName = item.impactedService?.service?.first?.serviceName,
            let serviceId = item.impactedService?.service?.first?.serviceId,
            let serviceBackColor = item.impactedService?.service?.first?.serviceBackColor else { return }
        
        for favorite in favArray {
            if item.impactedService?.service?.first?.serviceId == favorite.route {
                alerts.append(AlertObject(alertId: alertId, headLine: headline, shortDes: shortDescription, impact: impact, serviceName: serviceName, serviceId: serviceId, serviceBackColor: serviceBackColor))
            } else if item.impactedService?.service?.first?.serviceId == getTypeAlerts(favorite.type) {
                alerts.append(AlertObject(alertId: alertId, headLine: headline, shortDes: shortDescription, impact: impact, serviceName: serviceName, serviceId: serviceId, serviceBackColor: serviceBackColor))
            }
        }
    }
    completion(alerts.unique(map: {$0.shortDes}).sorted(by: {$0.serviceName < $1.serviceName}), .none)
}

// MARK: - Structs for CTA alerts XML
struct CTAAlerts: Codable {
    var alert: [Alert]?
    
    private enum CodingKeys: String, CodingKey {
        case alert = "Alert"
    }
}

struct Alert: Codable {
    let alertId: String?
    let headline: String?
    let shortDescription: String?
    let impact: String?
    let impactedService: ImpactedService?
    
    private enum CodingKeys: String, CodingKey {
        case alertId = "AlertId"
        case headline = "Headline"
        case shortDescription = "ShortDescription"
        case impact = "Impact"
        case impactedService = "ImpactedService"
    }
}

struct ImpactedService: Codable {
    let service: [Service]?
    
    private enum CodingKeys: String, CodingKey {
        case service = "Service"
    }
}

struct Service: Codable {
    let serviceName: String?
    let serviceId: String?
    let serviceBackColor: String?
    
    private enum CodingKeys: String, CodingKey {
        case serviceName = "ServiceName"
        case serviceId = "ServiceId"
        case serviceBackColor = "ServiceBackColor"
    }
}



//
//  FavoritesRowController.swift
//  Commuter Buddy Watch - CTA Version Extension
//
//  Created by Rob on 12/12/17.
//  Copyright © 2017 Max OSX. All rights reserved.
//

import WatchKit

class FavoritesRowController: NSObject {

    @IBOutlet var favoritesName: WKInterfaceLabel! {
        didSet(oldValue) {
            favoritesName.setTextColor(UIColor.white)
        }
    }
    @IBOutlet var mainGroup: WKInterfaceGroup!
}

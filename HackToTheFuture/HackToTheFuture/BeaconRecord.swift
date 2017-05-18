//
//  BeaconRecord.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

public class BeaconRecord: Object {
    dynamic var index = 0
    dynamic var beaconUdid = ""
    dynamic var category = ""
    dynamic var lat : Double = 0.0
    dynamic var lon : Double = 0.0
    dynamic var title = ""
    dynamic var subTitle = ""
    dynamic var address = ""
    dynamic var body = ""
    dynamic var imageUrl = ""
    dynamic var contactWebsite = ""
    
    override public class func primaryKey() -> String? {
        return "index"
    }
}

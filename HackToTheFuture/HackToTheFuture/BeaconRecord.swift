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
}

class BeaconLoader: NSObject {
    
    let realm = try! Realm()

    func load() {
        let path = Bundle.main.path(forResource: "Locations", ofType: "plist")
        if let dict = NSDictionary(contentsOfFile: path!) {
            if let array = dict["Locations"] as? [[String : Any]] {
            realm.beginWrite()

            for item in array {
                let title = self.validateString(item["title"])
                if title != "" {
                    let predicate = NSPredicate(format:"title == %@", title)
                    let results = realm.objects(BeaconRecord.self).filter(predicate)
                    
                    var rec : BeaconRecord
                    if results.count == 0 {
                        rec = BeaconRecord()
                        rec.title = title
                    } else {
                        rec = results.first!
                    }
                    
                    rec.category = self.validateString(item["category"])
                    rec.lat = self.validateDouble(item["lat"])
                    rec.lon = self.validateDouble(item["lon"])
                    
                    rec.title = title
                    rec.subTitle = self.validateString(item["subTitle"])
                    rec.address = self.validateString(item["address"])
                    rec.body = self.validateString(item["body"])
                    rec.imageUrl = self.validateString(item["imageUrl"])
                    rec.contactWebsite = self.validateString(item["www"])
                    rec.beaconUdid = self.validateString(item["beaconUUID"])

                    realm.add(rec)
                }}
            }
        
            try! realm.commitWrite()
        }
    }

    func validateString(_ field : Any?) -> String {
        if let string = field as? String {
            return string
        } else {
            return ""
        }
    }
    
    func validateInt(_ field : Any?) -> Int {
        if let value = field as? Int {
            return value
        } else if let value = field as? String {
            return Int(value)!
        } else {
            return 0
        }
    }
    
    func validateDouble(_ field : Any?) -> Double {
        if let value = field as? Double {
            return value
        } else if let value = field as? String {
            return Double(value)!
        } else {
            return 0.0
        }
    }
}

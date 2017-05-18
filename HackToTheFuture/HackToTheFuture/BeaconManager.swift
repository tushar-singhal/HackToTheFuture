//
//  BeaconManager.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit
import ProximityKit
import UserNotifications
import RealmSwift


class BeaconManager: NSObject, RPKManagerDelegate {

    static let shared = BeaconManager()

    let kNotifBeacon = Notification.Name(rawValue: "NotifBeacon")
    
    var kit : RPKManager?
    
    override init() {
        super.init()
        
        let configDict: [String:Any] = [
            "PKAPIToken": "cd3755cd294128638cf3a4ed4326e3869061719faf83873b1c05dd5169df081f",
            "PKGlobalUserIdentifier": 14373,
            "PKKitName": "Hackathon",
            "PKKitURL": "https://proximitykit.radiusnetworks.com/api/kits/9180",
            "PKMapName": "HackArea",
            "PKMapURL": "https://proximitykit.radiusnetworks.com/api/maps/2623",
            "PKUserEmail": "dominicfrazer@yahoo.co.uk",
            "PKUserIdentifier": 9645
        ]
        
        self.kit = RPKManager(delegate:self, andConfig:configDict)
        
        if let proximityKitManager = self.kit {
            proximityKitManager.start()
        }
    }
    
    func proximityKitDidSync(_ manager : RPKManager) {
        print("Proximity Kit did sync")
    }
    
    func proximityKit(_ manager: RPKManager!, didDetermineState state: RPKRegionState, for region: RPKRegion!) {
        
        var stateDescription: String
        
        switch (state) {
        case .inside:
            stateDescription = "Inside"
        case .outside:
            stateDescription = "Outside"
        case .unknown:
            stateDescription = "Unknown"
        }
        
        print("State Changed: \(stateDescription) Region \(region.name) (\(region.identifier))")
    }
    
    func proximityKit(_ manager : RPKManager, didEnter region:RPKRegion) {
        print("Entered Region \(region.name), \(region.identifier)");
    }
    
    func proximityKit(_ manager : RPKManager, didExit region:RPKRegion) {
        print("Exited Region \(region.name), \(region.identifier)");
    }
    
    func proximityKit(_ manager: RPKManager!, didRangeBeacons beacons: [Any]!, in region: RPKBeaconRegion!) {
        for beacon in beacons as! [RPKBeacon] {
            print("Major: \(beacon.major), Minor: \(beacon.minor)")
            
            scheduleLocal(beacon.uuid, major : beacon.major)
        }
    }
    
    func scheduleLocal(_ uuid : UUID, major : NSNumber) {
        let content = UNMutableNotificationContent()
        
        content.title = "Hack To The Future"
        content.body = "We found a beacon"
        
        let realm = try! Realm()
        let predicate = NSPredicate.init(format: "(beaconUdid == '\(uuid.uuidString)')")
        let results = realm.objects(BeaconRecord.self).filter(predicate)
        if results.count > 0 {
            let rec = results.first
            content.title = rec?.title ?? "Hack"
            content.body = rec?.body ?? "To The Future"
        }
        
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)
        
        NotificationCenter.default.post(name: kNotifBeacon, object: content.title)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (_) in }
    }
}

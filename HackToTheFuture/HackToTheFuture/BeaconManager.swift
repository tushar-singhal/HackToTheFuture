//
//  BeaconManager.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit
import ProximityKit

class BeaconManager: NSObject, RPKManagerDelegate {

    static let shared = BeaconManager()
    
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
        }
    }
}

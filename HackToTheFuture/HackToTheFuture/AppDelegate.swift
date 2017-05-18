//
//  AppDelegate.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let deleteOldDatabase = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Helpers.cleanImageCache()
        self.setupDatabase()
        self.registerForLocalNotif()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setupDatabase() {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileUrl = URL.init(string: documents.appending("//default-v1.realm"))
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration.init(fileURL: fileUrl,
                                                                            inMemoryIdentifier: nil,
                                                                            syncConfiguration: nil,
                                                                            encryptionKey: nil,
                                                                            readOnly: false,
                                                                            schemaVersion: 1,
                                                                            migrationBlock: nil,
                                                                            deleteRealmIfMigrationNeeded: true,
                                                                            objectTypes: [OfferRecord.self,
                                                                                          BeaconRecord.self])
        print("\(Realm.Configuration.defaultConfiguration.fileURL!)")
        if deleteOldDatabase {
            do {
                try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            } catch {}
        }
    }
    
    func registerForLocalNotif() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            //Parse errors and track state
        }
    }
}


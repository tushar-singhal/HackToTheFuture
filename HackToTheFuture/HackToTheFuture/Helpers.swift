//
//  Helpers.swift
//  BCCApp
//
//  Created by Dominic Frazer Imregh on 22/03/2017.
//  Copyright © 2017 BudapestCanoe. All rights reserved.
//

import UIKit

class Helpers: NSObject {
    
    static var cachePath = ""
    class func cacheFolder() -> String {
        if cachePath == "" {
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let dir: AnyObject = paths[0] as AnyObject
            cachePath = dir.appendingPathComponent("cacheImages")
        }
        return cachePath
    }
    
    class func fileExists(_ filePath: String) -> Bool {
        if filePath.characters.count > 0 {
            let fileManager = FileManager.default
            return fileManager.fileExists(atPath: filePath)
        } else {
            return false;
        }
    }
    
    class func cachePath(_ fileName: String) -> String {
        let filePath = "\(Helpers.cacheFolder())/\(fileName)"
        return filePath
    }
    
    class func checkAndCreateImageCacheFolder() {
        let fileManager = FileManager.default;
        do {
            try fileManager.createDirectory(atPath: Helpers.cacheFolder(), withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("checkAndCreateImageCacheFolder \(error.localizedDescription)")
        }
    }
    
    class func cleanImageCache() {
        Helpers.checkAndCreateImageCacheFolder()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let fileManager = FileManager.default;
            
            let cacheUrl = URL(fileURLWithPath: Helpers.cacheFolder(), isDirectory: true)
            let resourceKeys = [URLResourceKey.contentModificationDateKey]
            let fileEnumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(at: cacheUrl, includingPropertiesForKeys: resourceKeys, options: .skipsHiddenFiles, errorHandler: nil)!
            
            let expireDate = Date.init(timeIntervalSinceNow: -60.0 * 60.0 * 24.0 * 14.0)
            
            for file in fileEnumerator {
                if let fileUrl = file as? URL {
                    do {
                        let values = try fileUrl.resourceValues(forKeys: [URLResourceKey.contentModificationDateKey])
                        if let interval = values.contentModificationDate?.timeIntervalSince(expireDate) {
                            if interval < TimeInterval.init(0) {
                                do {
                                    try fileManager.removeItem(at: fileUrl)
                                } catch {
                                    
                                }
                            }
                        }
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    class func showAnimate(_ view : UIView, show : Bool) {
        Helpers.showAnimateAlpha(view, show: show, alpha: 1.0)
    }
    
    class func showAnimateHalf(_ view : UIView, show : Bool) {
        Helpers.showAnimateAlpha(view, show: show, alpha: 0.5)
    }
    
    class func showAnimateAlpha(_ view : UIView, show : Bool, alpha : CGFloat) {
        if view.isHidden == !show && alpha == 1.0 {
            return
        }
        view.alpha = show ? alpha : 1.0
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = show ? 1.0 : alpha
        }, completion: { (Bool) in
            if alpha == 1.0 {
                view.isHidden = !show
            }
        })
    }
        
}

//
//  CustomImageView.swift
//  BCCApp
//
//  Created by Dominic Frazer Imregh on 22/03/2017.
//  Copyright © 2017 BudapestCanoe. All rights reserved.
//

import Realm
import RealmSwift

class CustomImageView: UIImageView {
    
    var transitionType: String = kCATransitionFade
    var transitionSubType: String = ""  //kCATransitionFromRight, kCATransitionFromLeft
    var uniqueId = UUID.init().uuidString
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.imageClear()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageClear()
    }
    
    func buildImage(_ imageUrl : String) {
        uniqueId = UUID.init().uuidString
        var ok = false
        if imageUrl != "" {
            if imageUrl.contains("http") {
                let filename = self.urlToFilename(imageUrl)
                self.imageLoad(filename, urlString: imageUrl)
            } else {
                self.image = UIImage.init(named: imageUrl)
            }
            ok = true
        }
        if !ok {
            self.image = nil
        }
    }
    
    func buildFromIndex(_ index : Int) {
        uniqueId = UUID.init().uuidString
        if index > 0 {
            let filePath = FileHelpers().retrieveFilePath(index, primary: true)
            if filePath != "" {
                if let fullPath = Bundle.main.path(forResource: filePath, ofType: nil) {
                    _ = self.imageSet(fullPath, transition: false)
                }
            }
        } else {
            self.image = nil
        }
        
    }

    func urlToFilename(_ url : String) ->String {
        var filename = url.replacingOccurrences(of: "/", with: "")
        filename = filename.replacingOccurrences(of: ".", with: "")
        filename = filename.replacingOccurrences(of: "?", with: "")
        filename = filename.replacingOccurrences(of: ":", with: "")
        return filename
    }
    
    func imageLoad(_ fileName: String, urlString: String?) {
        if fileName == "" {
            return
        }
        
        if !self.imageSet(Helpers.cachePath(fileName), transition: false) {
            DownloadQueue.shared.addImageDownload(fileName, urlString: urlString!, uuid : self.uniqueId) { (success, uuid) -> Void in
                if success && uuid == self.uniqueId {
                    let _ = self.imageSet(Helpers.cachePath(fileName), transition: true)
                }
            }
        }
    }
    
    func imageSet(_ filePath: String, transition : Bool) -> Bool {
        if Helpers.fileExists(filePath) {
            DispatchQueue.main.async(execute: {
                CATransaction.setAnimationDuration(transition ? 0.3 : 0.0)
                
                let transition = CATransition()
                if self.transitionType.characters.count > 0 {
                    transition.type = self.transitionType
                }
                if self.transitionSubType.characters.count > 0 {
                    transition.subtype = self.transitionSubType
                }
                self.layer.add(transition, forKey: kCATransition)
                self.image = UIImage.init(contentsOfFile: filePath)
                CATransaction.commit()
            })
            
            do {
                let fileUrl = NSURL.init(fileURLWithPath: filePath)
                var values = URLResourceValues()
                values.contentModificationDate = Date()
                try fileUrl.setResourceValues(values.allValues)
            } catch {
                
            }
            
            return true
        } else {
            self.imageClear()
            return false
        }
    }
    
    func imageClear() {
        DispatchQueue.main.async(execute: {
            self.image = nil
            self.backgroundColor = UIColor.clear
        })
    }
}

extension FileManager {
    
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}

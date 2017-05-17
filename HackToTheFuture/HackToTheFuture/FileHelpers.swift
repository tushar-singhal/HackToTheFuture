//
//  FileHelpers.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

class FileHelpers: NSObject {
    
    func retrieveFile(_ index : Int, primary : Bool) -> UIImage {
        let filePath = self.retrieveFilePath(index, primary: primary)
        if filePath != "" {
            if let file = Bundle.main.path(forResource: filePath, ofType: "", inDirectory: nil) {
                let image =  UIImage.init(contentsOfFile: file)
                return image!
            }
        }
        //            return [PSCoreDataSpecialPhotos retrieveRandomPhoto];
        return UIImage()    //TODO
    }
    
    func retrieveFilePath(_ index : Int, primary : Bool) -> String {
        let arrayFilePaths = self.retrieveFilePaths(index)
        if arrayFilePaths.count > 0 {
            if primary {
                return arrayFilePaths.first!
            } else {
                return arrayFilePaths.last!
            }
        }
        return ""
    }
    
    func retrieveFilePaths(_ index : Int) -> [String] {
        var array : [String] = []
        let prefix = "\(index)"
        
        let docDir = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: nil)
        for path in docDir {
            if let file = path.components(separatedBy: "/").last {
                if file.hasPrefix(prefix) {
                    array.append(file)
                }
            }
        }
        return array.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    }

}

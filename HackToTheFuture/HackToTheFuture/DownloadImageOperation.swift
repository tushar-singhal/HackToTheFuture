//
//  DownloadImageOperation.swift
//  BCCApp
//
//  Created by Dominic Frazer Imregh on 22/03/2017.
//  Copyright © 2017 BudapestCanoe. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

enum ImageState {
    case new
    case done
    case fail
}

class ImageItem {
    var name: String
    let url: URL?
    var image = UIImage.init()
    var state = ImageState.new
    var uuid = ""
    
    init(name: String, urlString: String, uuid: String) {
        self.name = name
        let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! as String
        self.url = URL(string: urlStr)
        self.uuid = uuid
    }
}

class DownloadImageOperation: Operation {
    let item: ImageItem
    var completion: ((Bool, String) -> Void)? = nil
    
    init(item: ImageItem, completion: ((Bool, String) -> Void)?) {
        self.item = item
        self.completion = completion
    }
    
    override func main() {
        if self.isCancelled || self.item.url == nil {
            return
        }
        
        let filePath = Helpers.cachePath(self.item.name)
        if Helpers.fileExists(filePath) {
            self.item.image = UIImage.init(contentsOfFile: filePath)!
            self.item.state = .done
            self.completion?(true, self.item.uuid)
            return
        }
        
        let data = try? Data(contentsOf: self.item.url!)
        
        if self.isCancelled {
            return
        }
        
        if data?.count > 0 {
            let contentType = self.contentTypeForImageData(data!)
            if contentType == "image/jpeg" || contentType == "image/png" || contentType == "image/gif" {
                self.item.image = UIImage.init(data: data!)!
                let fileUrl = URL(fileURLWithPath: filePath)
                if contentType == "image/jpeg" {
                    try? UIImageJPEGRepresentation(self.item.image, 100)!.write(to: fileUrl, options: [.atomic])
                } else if contentType == "image/png" {
                    try? UIImagePNGRepresentation(self.item.image)!.write(to: fileUrl, options: [.atomic])
                } else if contentType == "image/gif" {
                    try? UIImagePNGRepresentation(self.item.image)!.write(to: fileUrl, options: [.atomic])
                }
                self.item.state = .done
                self.completion?(true, self.item.uuid)
            } else {
                self.item.state = .fail
                self.completion?(false, self.item.uuid)
            }
        } else {
            self.item.state = .fail
            self.completion?(false, self.item.uuid)
        }
    }
    
    func contentTypeForImageData(_ imageData: Data) -> String {
        var c: uint_fast8_t = 0
        (imageData as NSData).getBytes(&c, length: 1)
        
        switch c
        {
        case 0xd8, 0xFF:
            return "image/jpeg"
        case 0x50, 0x4e, 0x0d, 0x0a, 0x1a, 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        case 0x42:
            return "@image/bmp"
        default:
            return ""
        }
    }
}

extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

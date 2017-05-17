//
//  DownloadQueue.swift
//  BCCApp
//
//  Created by Dominic Frazer Imregh on 22/03/2017.
//  Copyright © 2017 BudapestCanoe. All rights reserved.
//

import UIKit

class DownloadQueue: NSObject {
    
    static let shared = DownloadQueue()
    
    let operationQueue = OperationQueue.init()
    
    override init() {
        self.operationQueue.name = "DownloadQueue"
        self.operationQueue.maxConcurrentOperationCount = 3
    }
    
    func cancelAll() {
        self.operationQueue.cancelAllOperations()
    }
    
    func addImageDownload(_ fileName: String, urlString: String, uuid: String, completion: ((Bool, String) -> Void)?) {
        let item = ImageItem.init(name: fileName, urlString: urlString, uuid: uuid)
        let operation = DownloadImageOperation.init(item: item, completion: completion)
        self.operationQueue.addOperation(operation)
    }
}

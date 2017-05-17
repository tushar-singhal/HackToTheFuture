//
//  Filters.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

enum FilterTypes {
    case notDefined
    case atm
    case branch
    case store
    case more
    
    func getTitle() -> String {
        switch self {
        case .atm:
            return "ATMs"
        case .branch:
            return "Branches"
        case .store:
            return "Stores"
        case .more:
            return "More..."
        default:
            return ""
        }
    }

    func getNearMe() -> String {
        switch self {
        case .atm:
            return "3 near you"
        case .branch:
            return "1 near you"
        case .store:
            return "1 near you"
        default:
            return ""
        }
    }
    
    func filterValue() -> String {
        switch self {
        case .atm:
            return "A"
        case .branch:
            return "B"
        case .store:
            return "C"
        default:
            return ""
        }
    }
}

var arrayFilters : [FilterTypes] = []

class Filters: NSObject {
    func predicate(all : Bool) ->NSPredicate {
        
        var filterCodes : [String] = []
        for filter in arrayFilters {
            filterCodes.append(filter.filterValue())
        }
        
        if filterCodes.count > 0 {
            var predicateArray : [NSPredicate] = []
            for code in filterCodes {
                let predicate = NSPredicate.init(format: "(category CONTAINS '\(code)')")
                predicateArray.append(predicate)
            }
            let predicate = NSCompoundPredicate.init(orPredicateWithSubpredicates: predicateArray)
            return predicate
        } else {
            let predicate = NSPredicate.init(format: "category != ''")
            return predicate
        }
    }
}

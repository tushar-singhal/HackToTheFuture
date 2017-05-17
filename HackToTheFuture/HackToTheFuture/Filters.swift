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
}

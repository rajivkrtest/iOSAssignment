//
//  APIClientConstants.swift
//  iOSAssignment
//
//  Created by Rajiv Kumar on 03/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
open class APIClientConstants {
    static let endpoint: String = "https://dl.dropboxusercontent.com"
    
    enum Resource : CustomStringConvertible {
        case facts;
        var description : String {
            switch self {
            case .facts: return "/s/2iodh4vg0eortkl/facts.json";
            }
        }
        
        var url : String {
            switch self {
            case .facts: return "\(APIClientConstants.endpoint)\(APIClientConstants.Resource.facts)"
            }
        }
    }
}

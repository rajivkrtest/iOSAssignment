//
//  FactsResponse.swift
//  iOSAssignment
//
//  Created by Rajiv Kumar on 03/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Row {
    var descriptionField : String!
    var imageHref : AnyObject!
    var title : String!
    
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String
        imageHref = dictionary["imageHref"] as AnyObject
        title = dictionary["title"] as? String
    }

}

struct FactsResponse {

    var rows : [Row]!
    var title : String!

    init(fromDictionary dictionary: [String:Any]){
        rows = [Row]()
        if let rowsArray = dictionary["rows"] as? [[String:Any]]{
            for dic in rowsArray{
                let value = Row(fromDictionary: dic)
                rows.append(value)
            }
        }
        title = dictionary["title"] as? String
    }

}

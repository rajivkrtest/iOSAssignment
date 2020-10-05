//
//  APIClient.swift
//  iOSAssignment
//
//  Created by Rajiv Kumar on 03/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum APIError: Error {
    case responseStatusError(status: Int, message: String)
    var errorDescription : String {
        switch self {
        case .responseStatusError(let errorDescription): return errorDescription.message
        }
    }
}

class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class APIClient: NSObject {

    internal typealias failureClosure = (_ error: APIError?) -> Void
    
    static let shared: APIClient = {
        let instance = APIClient()
        return instance
    }()
    
    func getFacts(parameters: [String: Any], completion: @escaping (_ results: FactsResponse?) -> Void, failure: @escaping failureClosure) -> Void {
        
        if NetworkState.isConnected() {
            self.getResponse(APIClientConstants.Resource.facts.url, parameters: parameters, completion: { (results) in
                if let results = results {
                    let response = FactsResponse(fromDictionary: results)
                    completion(response)
                }
            }, failure: failure)
        } else {
            failure(APIError.responseStatusError(status: -1, message: "No network available"))
        }
    }
    
    func getResponse(_ strURL : String, parameters: [String: Any], completion: @escaping (_ results: [String : Any]?) -> Void, failure: @escaping failureClosure) -> Void {
        var string: String = ""
        for key in parameters.keys {
            if let value = parameters[key] {
                let params = "&\(key)=\(value)"
                string = string + params
            }
        }
        var newURLString: String = strURL
        if !string.isEmpty {
            newURLString = "\(newURLString)\(string)"
        }
        AF.request(strURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case let .success(value):
                let json = JSON(parseJSON: value)
                if let dictionaryObject = json.dictionaryObject {
                    completion(dictionaryObject)
                } else {
                    failure(APIError.responseStatusError(status: -1, message: "Invalid Response"))
                }
                break
            case let .failure(error):
                failure(APIError.responseStatusError(status: -1, message: error.localizedDescription))
                break
            }
        }
    }
}

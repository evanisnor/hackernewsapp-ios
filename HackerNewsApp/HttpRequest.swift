//
//  HttpRequest.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/29/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias HTTPResult = (Int, JSON) -> Void
typealias HTTPError = (Int?, NSError) -> Void

class HttpRequest {
    
    static func parseHttpsURL (path: String) -> NSURL {
        let components = NSURLComponents(string: path)
        return (components?.URL)!
    }
    
    static func createGetRequest (path: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: parseHttpsURL(path))
        request.HTTPMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func makeHttpGetRequest (path: String, onResult: HTTPResult, onError: HTTPError) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(createGetRequest(path), completionHandler: { data, response, error in
            if error != nil && response != nil {
                onError((response as! NSHTTPURLResponse).statusCode, error!)
                return
            } else if (error != nil) {
                onError(nil, error!)
                return
            }
            
            onResult((response as! NSHTTPURLResponse).statusCode, JSON(data:data!))
            
        })
        task.resume()
    }

}
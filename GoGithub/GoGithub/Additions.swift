//
//  Additions.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

extension NSMutableURLRequest
{
    class func requestWithAPIRequest(apiRequest: APIRequest) -> NSMutableURLRequest
    {
        let request = NSMutableURLRequest()
        var requestURL = NSURL(string:"\(apiRequest.url())?")
        if let httpBody = apiRequest.httpBody()
        {
            request.HTTPBody = httpBody
        }
        if let apiQuery = apiRequest.queryStringParameters()
        {
            var queryArray = [String]()
            var queryString = String()
            for (key,value) in apiQuery
            {
                queryArray.append("\(key)=\(value)")
            }
            queryString = queryArray.joinWithSeparator("&")
            if let encodedHost = queryString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            {
                requestURL = NSURL (string:"\(apiRequest.url())?".stringByAppendingString(encodedHost))!
            }
        }
        if let apiHeaders = apiRequest.httpHeaders()
        {
            for(key, value) in apiHeaders
            {
                request.setValue(value, forKey: key)
            }
            
        }
        request.URL = requestURL
        request.HTTPMethod = apiRequest.httpMethod.rawValue
        return request
    }
}


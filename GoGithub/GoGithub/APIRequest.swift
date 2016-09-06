//
//  APIRequest.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

enum MIMEType: String
{
    case ApplicationXWWWFormUrlEncoded = "application/x-www.form-urlencoded"
    case ApplicationJSON = "application/json"
}

enum HTTPMethod: String
{
    case POST = "POST"
    case GET = "GET"
    case DELETE = "DELETE"
    case PUT = "PUT"
    
}
protocol APIRequest
{
    var httpMethod: HTTPMethod {set get}
    func url() -> String
    func httpHeaders() -> [String: String]?
    func httpBody()->NSData?
    func queryStringParameters() -> [String:String]?
}

extension APIRequest
{
    func httpHeaders() -> [String:String]?
    {
        return nil
    }
    func httpBody() -> NSData?
    {
        return nil
    }
    func queryStringParameters() -> [String:String]?
    {
        return nil 
    }
}

//
//  SearchAPI.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/24/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation


class Search: APIRequest
{
    var httpMethod = HTTPMethod.GET
    var headerContent = MIMEType.ApplicationJSON
    
    var searchTerm: String
    
    init(searchTerm: String)
    {
        self.searchTerm = searchTerm
    }
    
    func url() -> String
    {
        return "https://api.github.com/search/repositories"
    }
    
    func queryStringParameters() -> [String : String]? {
        do {
            let token = try GithubOAuth.shared.accessToken()
            return ["access_token": token, "q" : self.searchTerm]
        }catch _ {}
        return nil
    }
}


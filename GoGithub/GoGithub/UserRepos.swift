//
//  UserRepos.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/25/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

class UserRepo: APIRequest
{
    var httpMethod = HTTPMethod.GET
    var headerContent = MIMEType.ApplicationJSON
    
    var username: String
    
    init(username: String)
    {
        self.username = username
    }
    
    func url() -> String
    {
        return "https://api.github.com/users/\(username)/repos"
    }
    
    func queryStringParameters() -> [String : String]? {
        do {
            let token = try GithubOAuth.shared.accessToken()
            return ["access_token": token, "q" : self.username]
        }catch _ {}
        return nil
    }
}
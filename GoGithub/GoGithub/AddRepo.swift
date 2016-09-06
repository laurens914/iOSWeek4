//
//  AddRepo.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/24/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation


class AddRepo: APIRequest
{
    var httpMethod = HTTPMethod.POST
    
    let repoName: String
    
    init(repoName: String)
    {
        self.repoName = repoName
    }
    
    func url() -> String
    {
       return "https://api.github.com/user/repos" 
    }
    
    func queryStringParameters() -> [String : String]? {
        do {
            let token = try GithubOAuth.shared.accessToken()
            return ["access_token": token]
        }catch _ {}
        return nil
    }
    
    func httpBody() -> NSData?
    {
        return try! NSJSONSerialization.dataWithJSONObject(["name" : self.repoName], options: .PrettyPrinted)
    }
}
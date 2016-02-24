//
//  CurrentUserRequest.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

class GetCurrentUserRequest: APIRequest {
    var httpMethod = HTTPMethod.GET
    var headerContent = MIMEType.ApplicationJSON
    
    func url() -> String {
        return "https://api.github.com/user"
    }
    
    func queryStringParam() -> [String : String]? {
        do {
            let token = try GithubOAuth.shared.accessToken()
            return ["access_token": token]
        }  catch _ {}
        return nil
    }
}
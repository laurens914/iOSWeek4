//
//  ModelAdditions.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

extension Repo
{
    class func update(completion:(success:Bool, repos:[Repo]) -> ())
    {
        API.shared.enqueue(GetRepoRequest()) { (success, json) -> () in
            
                var repos = [Repo]()
                
            for eachRepo in json {
                let name = eachRepo["name"] as? String ?? kEmptyString
                let desc = eachRepo["description"] as? String ?? kEmptyString
                
                let ownerName = eachRepo["owner"]?["login"] as? String ?? kEmptyString
                let ownerProfileLink = eachRepo["owner"]?["html_url"] as? String ?? kEmptyString
                let ownerRepoLink = eachRepo["owner"]?["repos_url"] as? String ?? kEmptyString
                let owner = Owner(name: ownerName, linkToRepos: ownerRepoLink, profileLink: ownerProfileLink)
                repos.append(Repo(name: name, owner: owner, desc: desc))
            }
            NSOperationQueue.mainQueue().addOperationWithBlock{ completion(success: true, repos: repos)}
        }
    }
}

extension CurrentUser {
    class func update(completion: (success: Bool, user: [CurrentUser]) -> ()) {
        API.shared.enqueue(GetCurrentUserRequest()) { (success, json) -> () in
            var currUser = [CurrentUser]()
            
            for user in json {
                let realName = user["name"] as? String ?? user["login"] as? String
                let userProfileLink = user["html_url"] as? String ?? kEmptyString
                let linkToRepos = user["repos_url"] as? String ?? kEmptyString
                let avatarURL = user["avatar_url"] as? String ?? kEmptyString
                let email = user["email"] as? String ?? kEmptyString
                currUser.append(CurrentUser(name: realName!, linkToRepos: linkToRepos, profileLink: userProfileLink, avatarURL: avatarURL, email: email))
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, user: currUser) }
            
        }
    }
}


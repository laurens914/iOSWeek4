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
                 let ownerProfileImage = eachRepo["owner"]?["avatar_url"] as? String ?? kEmptyString
                let owner = Owner(name: name,linkToRepos: ownerRepoLink, profileLink: ownerProfileLink, profileImage: ownerProfileImage, username: ownerName)
                repos.append(Repo(name: name, owner: owner, desc: desc))
            }
            NSOperationQueue.mainQueue().addOperationWithBlock{ completion(success: true, repos: repos)}
        }
    }
    class func searchGitHub(searchResults: String, completion:(success:Bool, repos:[Repo]) ->())
    {
        API.shared.enqueue(Search(searchTerm: searchResults)) { (success, json) -> () in
            var repos = [Repo]()
            
            for eachRepo in json {
                let name = eachRepo["name"] as? String ?? kEmptyString
                let desc = eachRepo["description"] as? String ?? kEmptyString
                
                let ownerName = eachRepo["owner"]?["login"] as? String ?? kEmptyString
                let ownerProfileLink = eachRepo["owner"]?["html_url"] as? String ?? kEmptyString
                let ownerRepoLink = eachRepo["owner"]?["repos_url"] as? String ?? kEmptyString
                let ownerProfileImage = eachRepo["owner"]?["avatar_url"] as? String ?? kEmptyString
                let owner = Owner(name: name, linkToRepos: ownerRepoLink, profileLink: ownerProfileLink, profileImage: ownerProfileImage, username: ownerName)
                repos.append(Repo(name: name, owner: owner, desc: desc))
            }
            NSOperationQueue.mainQueue().addOperationWithBlock{ completion(success: true, repos: repos)}
        }
    }
}
extension Owner
{
class func searchGitHubUsers(searchResults: String, completion:(success:Bool, owner:[Owner]) ->())
{
    API.shared.enqueue(UserSearch(searchTerm: searchResults)) { (success, json) -> () in
        var owner = [Owner]()
        
        for user in json {
                      
            let ownerUsername = user["login"] as? String ?? kEmptyString
            let ownerProfileLink = user["html_url"] as? String ?? kEmptyString
            let ownerRepoLink = user["repos_url"] as? String ?? kEmptyString
            let ownerProfileImage = user["avatar_url"] as? String ?? kEmptyString
            let ownerName = user["name"] as? String ?? kEmptyString
            owner.append(Owner(name: ownerName,linkToRepos: ownerRepoLink, profileLink: ownerProfileLink, profileImage: ownerProfileImage, username: ownerUsername ))
        }
        NSOperationQueue.mainQueue().addOperationWithBlock{ completion(success: true, owner: owner)}
    }
}
    class func githubUserRepos(username: String, completion:(success:Bool, repos:[Repo]) -> ())
    {
        API.shared.enqueue(UserRepo(username: username)) { (success, json) -> () in
            
            var repos = [Repo]()
            print(json)
            for eachRepo in json {
                let name = eachRepo["name"] as? String ?? kEmptyString
                let desc = eachRepo["description"] as? String ?? kEmptyString
                
                let ownerName = eachRepo["owner"]?["login"] as? String ?? kEmptyString
                let ownerProfileLink = eachRepo["owner"]?["html_url"] as? String ?? kEmptyString
                let ownerRepoLink = eachRepo["owner"]?["repos_url"] as? String ?? kEmptyString
                let ownerProfileImage = eachRepo["owner"]?["avatar_url"] as? String ?? kEmptyString
                let owner = Owner(name: name,linkToRepos: ownerRepoLink, profileLink: ownerProfileLink, profileImage: ownerProfileImage, username: ownerName)
                repos.append(Repo(name: name, owner: owner, desc: desc))
            }
            NSOperationQueue.mainQueue().addOperationWithBlock{ completion(success: true, repos: repos)}
        }
    }
}


extension CurrentUser {
    class func update(completion: (success: Bool, user: CurrentUser?) -> ()) {
        API.shared.enqueue(GetCurrentUserRequest()) { (success, json) -> () in
            var currUsers = [CurrentUser]()
            
            print(json.count)
            
            for user in json {
                let realName = user["name"] as? String ?? user["login"] as? String
                let userProfileLink = user["html_url"] as? String ?? kEmptyString
                let linkToRepos = user["repos_url"] as? String ?? kEmptyString
                let avatarURL = user["avatar_url"] as? String ?? kEmptyString
                let email = user["email"] as? String ?? kEmptyString
                let login = user["login"] as? String ?? kEmptyString
                currUsers.append(CurrentUser(name: realName!, linkToRepos: linkToRepos, profileLink: userProfileLink, avatarURL: avatarURL, email: email, login:login))
            }
            if let user = currUsers.first {
                NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: true, user: user) }
                
            } else { NSOperationQueue.mainQueue().addOperationWithBlock { completion(success: false, user: nil) }
                
            }
        }
    }
}


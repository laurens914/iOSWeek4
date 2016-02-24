//
//  HomeViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Identity
{
    class func id() -> String {
        return "HomeViewController"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func repoButton(sender: UIButton) {
        Repo.update { (success, repos) -> () in
            if success {
                for repo in repos {
                    let descript = repo.desc == kEmptyString ? "No description provided" : repo.desc
                    print("\(repo.name) by \(repo.owner.name) -> View profile at \(repo.owner.profileLink) \n DESCRIPTION: \(descript) \n \n ")
                }
            }
        }
        
    }
    
    
    @IBAction func userButton(sender: AnyObject) {
        CurrentUser.update { (success, user) -> () in
            if success {
                for user in user {
                    print("");print("");
                    print(user.avatarURL)
                    print(user.email)
                    print(user.linkToRepos)
                    print(user.name)
                    print(user.profileLink)
                    print("");print("");
                }
            }
        }
    }


}

//
//  ViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/22/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController, Identity
{
    
    class func id()-> String {
        return "OAuthViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func githubAuthorization(sender: AnyObject) {
        GithubOAuth.shared.oAuthRequestWithScope("email,user,repo")
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}


//
//  ViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/22/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func githubAuthorization(sender: AnyObject) {
        GithubOAuth.shared.oAuthRequestWithScope("user,repo")
    }
    
    
    @IBAction func printToken(sender: AnyObject) {
        do {
            let token = try GithubOAuth.shared.accessToken()
             print(token)
        }catch _ {}

    }

}


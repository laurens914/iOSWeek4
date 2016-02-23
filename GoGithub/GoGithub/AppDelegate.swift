//
//  AppDelegate.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/22/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        GithubOAuth.shared.tokenRequestWithCallback(url, options: SaveOptions.Keychain) { (success) -> () in
            if success {
                print("Recieved Token")
            }
            
        }
        return true
        
        
    }
}


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
    var oauthViewController: OAuthViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        checkOAuthStatus()
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        GithubOAuth.shared.tokenRequestWithCallback(url, options: SaveOptions.Keychain) { (success) -> () in
            if success
            {
                guard let oauthViewController = self.oauthViewController else { return}
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    oauthViewController.view.alpha = 0.0
                    }, completion: { (finished) -> Void in
                        oauthViewController.view.removeFromSuperview()
                        oauthViewController.removeFromParentViewController()    
                })
            }
        
        }
        return true
        
        
    }
    
    func checkOAuthStatus()
    {
        do {
          let token = try GithubOAuth.shared.accessToken()
            print(token)
    
        } catch _ { self.presentOAuthViewController() }
    
    }
    func presentOAuthViewController()
        {
            guard let homeViewController = self.window?.rootViewController as? HomeViewController else { fatalError("root VC Changes") }
            guard let storyboard = homeViewController.storyboard else { fatalError("how does VC not have Storybaord") }
            guard let oauthViewController = storyboard.instantiateViewControllerWithIdentifier(OAuthViewController.id()) as? OAuthViewController else { fatalError() }

            homeViewController.addChildViewController(oauthViewController)
            homeViewController.view.addSubview(oauthViewController.view)
            oauthViewController.didMoveToParentViewController(homeViewController)

            self.oauthViewController = oauthViewController
    }
}





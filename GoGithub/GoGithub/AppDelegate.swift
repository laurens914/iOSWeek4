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
    var tabbarController: UITabBarController?
    var navigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.checkOAuthStatus()
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        
        GithubOAuth.shared.tokenRequestWithCallback(url, options: SaveOptions.UserDefaults) { (success) -> () in
            if success
            {
                guard let oauthViewController = self.oauthViewController else { return }
                guard let tabbarController = self.tabbarController else { return }
                guard let navigationController = self.navigationController else { return }
                guard let homeViewController = navigationController.viewControllers.first as? HomeViewController else {fatalError("homeVC not directory")}
                homeViewController.showRepos()
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    oauthViewController.view.alpha = 0.0
                    }, completion: { (finished) -> Void in
                        
                        navigationController.setNavigationBarHidden(false, animated: false)
                        tabbarController.tabBar.hidden = false
                        
                        
                        oauthViewController.view.removeFromSuperview()
                        oauthViewController.removeFromParentViewController()    
                })
            }
            else{
                print("FAIL!")
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
            guard let tabbarController = self.window?.rootViewController as? UITabBarController else { fatalError("root VC Changes") }
            guard let storyboard = tabbarController.storyboard else { fatalError("how does VC not have Storybaord") }
            guard let oauthViewController = storyboard.instantiateViewControllerWithIdentifier(OAuthViewController.id()) as? OAuthViewController else { fatalError() }
            
            guard let repoNavigationController = tabbarController.viewControllers?.first as? UINavigationController else { return }
            
            repoNavigationController.setNavigationBarHidden(true, animated: false)
            tabbarController.tabBar.hidden = true
            
            guard let repoViewController = repoNavigationController.viewControllers.first as? HomeViewController else { return }

            repoViewController.addChildViewController(oauthViewController)
            repoViewController.view.addSubview(oauthViewController.view)
            oauthViewController.didMoveToParentViewController(repoViewController)

            self.oauthViewController = oauthViewController
            self.tabbarController = tabbarController
            self.navigationController = repoNavigationController
    }
}





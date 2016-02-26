//
//  WebKitViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/25/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, Identity {
    
    var username: String?
    
    var owner: Owner? {
        didSet{
            if let owner = owner {
                print(owner.profileLink)
                
            self.username = owner.username
            }
        }
    }
    
    class func id() -> String {
        return "WebKitViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func webView(){
        if let owner = owner {
            let url = NSURL(string:owner.profileLink)
            let request = NSMutableURLRequest(URL: url!)
            let webView = WKWebView(frame: self.view.frame)
            self.view.addSubview(webView)
            webView.loadRequest(request)
        }
    }

}

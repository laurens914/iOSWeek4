//
//  HomeViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Identity, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var repositories = [Repo]() {
        didSet
        {
            self.tableView.reloadData()
        }
    }
    
    class func id() -> String {
        return "HomeViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.showRepos()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repoCell = self.tableView.dequeueReusableCellWithIdentifier("RepoCell", forIndexPath: indexPath)
        let repositoryRow = self.repositories[indexPath.row]
        repoCell.textLabel?.text = repositoryRow.name
        
        
        return repoCell
    }
    
    func showRepos()
    {
        Repo.update { (success, repos) -> () in
            self.repositories = repos
        }
       
        
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }

    
    
    
//    @IBAction func userButton(sender: AnyObject) {
//        CurrentUser.update { (success, user) -> () in
//            if success {
//                for user in user {
//                    print("");print("");
//                    print(user.avatarURL)
//                    print(user.email)
//                    print(user.linkToRepos)
//                    print(user.name)
//                    print(user.profileLink)
//                    print("");print("");
//                }
//            }
//        }
//    }


}

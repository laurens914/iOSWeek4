//
//  UserRepoListViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/25/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class UserRepoListViewController: UIViewController, Identity
{

    @IBOutlet weak var ownerRepoTableView: UITableView!
    @IBOutlet weak var repoOwnerImage: UIImageView!
    
    var selectedRepo:Repo?
    
    var userRepoArray = [Repo](){
        didSet{
        self.ownerRepoTableView.reloadData()
        }
    }

    
    var owner: Owner?

    
    class func id() -> String {
       return "UserRepoListViewController"
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUser()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func setupUser(){
        if let owner = owner {
            Owner.githubUserRepos((owner.username)) { (success, repos) -> () in
                self.userRepoArray = repos
               API.getImage(owner.profileImage, completion: { (image) -> () in
                self.repoOwnerImage.image = image 
               })
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == WebKitViewController.id() {
            guard let webKitViewController = segue.destinationViewController as? WebKitViewController else {
                fatalError("oops...") }
            webKitViewController.owner = self.owner
            
        }
    }

}

extension UserRepoListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userRepoCell = self.ownerRepoTableView.dequeueReusableCellWithIdentifier("UserRepoCell", forIndexPath: indexPath)
        let userRepoRow = userRepoArray[indexPath.row]
        userRepoCell.textLabel?.text = userRepoRow.name
        return userRepoCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userRepoArray.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(WebKitViewController.id(), sender: nil)
    }

    
}

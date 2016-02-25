//
//  ProfileViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/24/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var linkToUserRepos: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userRealName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func setupProfile()
    {
        CurrentUser.update { (success, user) -> () in
            if success {
                if let user = user{
                    self.linkToUserRepos.text = user.linkToRepos
                    self.username.text = user.login
                    self.userEmail.text = user.email
                    self.userRealName.text = user.name
                    API.getImage(user.avatarURL, completion: { (image) -> () in
                        self.profileImage.image = image
                    })
                }
                
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupProfile()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}

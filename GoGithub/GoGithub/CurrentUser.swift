//
//  CurrentUser.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

class CurrentUser {
    var name: String //NAME not LOGIN
    var linkToRepos: String
    var profileLink: String
    var avatarURL: String
    var email: String
    var login: String
    
    init(name: String, linkToRepos: String, profileLink: String, avatarURL: String, email: String, login: String) {
        self.name = name
        self.linkToRepos = linkToRepos
        self.profileLink = profileLink
        self.avatarURL = avatarURL
        self.email = email
        self.login = login 
    }
}
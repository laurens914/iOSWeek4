//
//  Repo.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/23/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

class Repo
{
    let name: String
    let owner: Owner
    let desc: String
    
    init(name: String, owner: Owner, desc: String) {
        self.name = name
        self.owner = owner
        self.desc = desc
    }
}

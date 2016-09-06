//
//  UserImageCollectionViewCell.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/25/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class UserImageCollectionViewCell: UICollectionViewCell, Identity
{
    @IBOutlet weak var userImage: UIImageView!
  
    class func id() -> String {
       return  "UserSearchViewController"
    }
    
    
    var owner: Owner?{
        didSet{
            if let owner = owner{
                API.getImage((owner.profileImage), completion: { (image) -> () in
                    self.userImage.image = image
                })
            }
        }
    }

    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.userImage.image = nil
    }
}

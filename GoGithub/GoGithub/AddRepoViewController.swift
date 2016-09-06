//
//  AddRepoViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/24/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class AddRepoViewController: UIViewController
{

    @IBOutlet weak var textField: UITextField!
    @IBAction func cancelButton(sender: AnyObject)
    {
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addRepoButton(sender: AnyObject) {
        API.shared.enqueue(AddRepo(repoName:textField.text!)) { (success, json) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

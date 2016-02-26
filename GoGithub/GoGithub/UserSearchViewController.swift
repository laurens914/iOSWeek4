//
//  UserSearchViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/25/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var selectedItem : Owner?
    var userSearchArray = [Owner](){
        didSet
        {
            self.collectionView.reloadData()
        }
    }
 
    @IBOutlet weak var userSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        Owner.searchGitHubUsers(searchBar.text!) { (success, owner) -> () in
            self.userSearchArray = owner
            for owner in owner {
                print(owner)
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == UserRepoListViewController.id() {
            guard let userRepoListViewController = segue.destinationViewController as? UserRepoListViewController else {
                fatalError("oops...") }
              userRepoListViewController.owner = self.selectedItem

        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if self.userSearchBar.isFirstResponder() {
            self.userSearchBar.resignFirstResponder()
        }
    }
    
}

extension UserSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.userSearchArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let userCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("UserImageCollectionViewCell", forIndexPath: indexPath) as! UserImageCollectionViewCell
    userCell.owner = self.userSearchArray[indexPath.row]
    return userCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected item at index: \(indexPath.row)")
        self.selectedItem = self.userSearchArray[indexPath.row]
        self.performSegueWithIdentifier(UserRepoListViewController.id(), sender: nil)
    }
}

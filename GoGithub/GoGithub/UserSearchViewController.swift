//
//  UserSearchViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/25/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController,UISearchBarDelegate, UIViewControllerTransitioningDelegate
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    let transition = CustomModalTransition(duratioin: 3)
    
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
            userRepoListViewController.transitioningDelegate = self
            userRepoListViewController.owner = self.selectedItem

        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if self.userSearchBar.isFirstResponder() {
            self.userSearchBar.resignFirstResponder()
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
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
        self.selectedItem = self.userSearchArray[indexPath.row]
        self.performSegueWithIdentifier(UserRepoListViewController.id(), sender: nil)
    }
}

class CustomModalTransition: NSObject, UIViewControllerAnimatedTransitioning
{
    var duration = 2.0
    
    init(duratioin: NSTimeInterval)
    {
        self.duration = duratioin
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {return}
        guard let containerView = transitionContext.containerView() else {return}
        
        let finalFrame = transitionContext.finalFrameForViewController(toViewController)
        let screenBounds = UIScreen.mainScreen().bounds
        
        toViewController.view.frame = CGRectOffset(finalFrame, 0.0, screenBounds.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            toViewController.view.frame = finalFrame
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
        }
    }
}


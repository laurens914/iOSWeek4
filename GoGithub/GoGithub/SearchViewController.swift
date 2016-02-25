//
//  SearchViewController.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/24/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var searchTableView: UITableView!
    var searchArray = [Repo](){
        didSet
        {
            self.searchTableView.reloadData()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        Repo.searchGitHub(searchText) { (success, repos) -> () in
            self.searchArray = repos 
            for repo in repos {
                print(repo.name)
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchRepoCell = self.searchTableView.dequeueReusableCellWithIdentifier("SearchRepoCell", forIndexPath: indexPath)
        let searchRow = self.searchArray[indexPath.row]
        searchRepoCell.textLabel?.text = searchRow.name
        return searchRepoCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.searchArray.count
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

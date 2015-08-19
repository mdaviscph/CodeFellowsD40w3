//
//  RepositorySearchViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class RepositorySearchViewController: UIViewController {

  var repositories = [Repo]()
  
  // MARK: IBOutlets
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.estimatedRowHeight = tableView.rowHeight
      tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    GitHubService.repositoriesForSearchTerm("q=test", controller: self)
  }
  
}

extension RepositorySearchViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(StoryboardConsts.RepositoryCellReuseIdentifier, forIndexPath: indexPath) as! RepositoryCell
    cell.repository = repositories[indexPath.row]
    return cell
  }
}
extension RepositorySearchViewController: UITableViewDelegate {
  
}

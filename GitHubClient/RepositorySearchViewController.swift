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
  
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
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
  }
  
  private func searchForRepositories(searchTerm: String) {
    repositories.removeAll()
    GitHubService.repositoriesUsingSearchTerm(searchTerm) { (data, statusCode, error) -> Void in
      NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        if let error = error {
          AlertOnSessionError.alertPopover(ErrorMessageConsts.nsURLSessionError, withNSError: error, controller: self)
        } else if let data = data {
          var error: NSError?
          let searchResultRepos = GitHubParser.reposFromData(data, error: &error)
          if let error = error {
            AlertOnSessionError.alertPopover(ErrorMessageConsts.nsJSONSerializationError, withNSError: error, controller: self)
          }
          else if let searchResultRepos = searchResultRepos {
            self.repositories += searchResultRepos
          }
        } else if let statusCode = statusCode {
          AlertOnSessionError.alertPopover(NSHTTPURLResponse.localizedStringForStatusCode(statusCode), withStatusCode: statusCode, controller: self)
        }
        self.tableView.reloadData()
      }
    }
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
extension RepositorySearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if !searchBar.text.isEmpty {
      searchForRepositories(searchBar.text)
    }
  }
}

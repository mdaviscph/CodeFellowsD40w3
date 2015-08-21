//
//  UserSearchViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/20/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
  var users = [User]()
  
  // MARK: IBOutlets
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
    }
  }
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func searchForUsers(searchTerm: String) {
    users.removeAll()
    GitHubService.usersUsingSearchTerm(searchTerm) { (data, statusCode, error) -> Void in
      NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        if let error = error {
          AlertOnSessionError.alertPopover(ErrorMessageConsts.nsURLSessionError, withNSError: error, controller: self)
        } else if let data = data {
          var error: NSError?
          if let searchResultUsers = GitHubParser.usersFromData(data, error: &error) {
            self.users += searchResultUsers
          } else if let error = error {
            AlertOnSessionError.alertPopover(ErrorMessageConsts.nsJSONSerializationError, withNSError: error, controller: self)
          }
        } else if let statusCode = statusCode {
          AlertOnSessionError.alertPopover(NSHTTPURLResponse.localizedStringForStatusCode(statusCode), withStatusCode: statusCode, controller: self)
        }
        self.collectionView.reloadData()
      }
    }
  }
}
extension UserSearchViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StoryboardConsts.UserCellReuseIdentifier, forIndexPath: indexPath) as! UserCell
    cell.user = users[indexPath.row]
    return cell
  }
}
extension UserSearchViewController: UICollectionViewDelegate {
  
}
extension UserSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if !searchBar.text.isEmpty {
      searchForUsers(searchBar.text)
    }
  }
}

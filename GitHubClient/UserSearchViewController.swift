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
  private var userAvatars = [String:UIImage]()
  
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
    
    let tag = ++cell.tag
    cell.avatarImage = nil
    cell.hidden = false
    
    let user = users[indexPath.row]
    cell.user = user
    if let image = userAvatars[user.login] {
      cell.avatarImage = image
    } else {
      let date = NSDate()
      ImageService.sharedInstance.imageInBackground(user.avatarURL, size: SizeConsts.userCellImageSize, withRoundedCorner: UIColor.whiteColor()) { (image) -> Void in
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
          if let image = image where cell.tag == tag {
            cell.avatarImage = image
          }
          println(String(format: "imageInBackground in %0.4f seconds", -date.timeIntervalSinceNow))
        }
      }
    }
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
//
//  UserSearchViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/20/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
  
  // MARK: Public Properties
  var users = [User]()
  
  // MARK: Private Properties
  private var userAvatars = [String:UIImage]()
  
  // MARK: IBOutlets
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
      searchBar.becomeFirstResponder()
    }
  }
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
    }
  }
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.delegate = self
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.delegate = nil
  }
  
  // MARK: Private Helper Methods
  private func searchForUsers(searchTerm: String) {
   GitHubService.usersUsingSearchTerm(searchTerm) { (data, statusCode, error) -> Void in
      NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        if let error = error {
          AlertOnSessionError.alertPopover(ErrorMessageConsts.nsURLSessionError, withNSError: error, controller: self)
        } else if let data = data {
          var error: NSError?
          let searchResultUsers = GitHubParser.usersFromData(data, error: &error)
          if let error = error {
            AlertOnSessionError.alertPopover(ErrorMessageConsts.nsJSONSerializationError, withNSError: error, controller: self)
          }
          else if let searchResultUsers = searchResultUsers {
            self.users += searchResultUsers
          }
        } else if let statusCode = statusCode {
          AlertOnSessionError.alertPopover(NSHTTPURLResponse.localizedStringForStatusCode(statusCode), withStatusCode: statusCode, controller: self)
        }
        self.collectionView.reloadData()
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == StoryboardConsts.UserViewControllerToUserDetatilSeque, let detailVC = segue.destinationViewController as? UserDetailViewController, indexPath = collectionView.indexPathsForSelectedItems().first as? NSIndexPath {
      let user = users[indexPath.row]
      detailVC.user = user
      detailVC.view.backgroundColor = collectionView.backgroundColor
      detailVC.textView.backgroundColor = collectionView.backgroundColor
      if let image = userAvatars[user.login] {
        detailVC.avatarImage = image
      }
    }
  }
}

// MARK: UICollectionViewDataSource
extension UserSearchViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StoryboardConsts.UserCellReuseIdentifier, forIndexPath: indexPath) as! UserCell
    
    let tag = ++cell.tag
    cell.avatarImage = nil
    cell.hidden = false
    cell.backgroundColor = collectionView.backgroundColor
    
    let user = users[indexPath.row]
    cell.user = user
    if let image = userAvatars[user.login] {
      cell.avatarImage = image
    } else {
      let date = NSDate()
      ImageService.sharedInstance.imageInBackground(user.avatarURL, size: SizeConsts.userAvatarImageSize, withRoundedCorner: collectionView.backgroundColor) { (image) -> Void in
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
          if let image = image where cell.tag == tag {
            cell.avatarImage = image
          }
          self.userAvatars[user.login] = image
          println(String(format: "imageInBackground in %0.4f seconds", -date.timeIntervalSinceNow))
        }
      }
    }
    return cell
  }
}

// MARK: UISearchBarDelegate
extension UserSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if !searchBar.text.isEmpty {
      users.removeAll()
      collectionView.reloadData()         // safe way to scroll to top prior to 2nd+ search
      searchForUsers(searchBar.text)
    }
  }
  // didn't use a String extension for RegEx in order to eventually support repository search qualifiers
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    var error: NSError?
    let regex = NSRegularExpression(pattern: StringConsts.searchRepositoryStringRegEx, options: nil, error: &error)
    if let matches = regex?.numberOfMatchesInString(text, options: nil, range: NSRange(location: 0, length: count(text))) {
      return matches == 0
    }
    return true
  }
}

// MARK: UINavigationControllerDelegate
extension UserSearchViewController: UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return toVC is UserDetailViewController ? ToUserDetailAnimationController() : nil
  }
}
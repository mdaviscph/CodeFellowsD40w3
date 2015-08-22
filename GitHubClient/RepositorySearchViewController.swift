//
//  RepositorySearchViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class RepositorySearchViewController: UIViewController {

  // MARK: Public Properties
  var repositories = [Repo]()
  
  // MARK: Private Properties
  private var jumpToURL: NSURL?

  // MARK: IBOutlets
  @IBOutlet private weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
      searchBar.becomeFirstResponder()
    }
  }
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      //tableView.estimatedRowHeight = tableView.rowHeight
      //tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == StoryboardConsts.RepositoryWebViewSegue, let webVC = segue.destinationViewController as? WebViewController, jumpToURL = jumpToURL {
      webVC.url = jumpToURL
    }
  }
  
  // MARK: Private Helper Methods
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

// MARK: UITableViewDataSource
extension RepositorySearchViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(StoryboardConsts.RepositoryCellReuseIdentifier, forIndexPath: indexPath) as! RepositoryCell
    cell.backgroundColor = tableView.backgroundColor
    cell.textViewBackgroundColor = cell.backgroundColor
    cell.textViewDelegate = self
    cell.repository = repositories[indexPath.row]
    return cell
  }
}

// MARK: UISearchBarDelegate
extension RepositorySearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if !searchBar.text.isEmpty {
      searchForRepositories(searchBar.text)
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

// MARK: UITextViewDelegate
extension RepositorySearchViewController: UITextViewDelegate {
  func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    println("push to webView: \(URL.absoluteString!)")
    jumpToURL = URL
    performSegueWithIdentifier(StoryboardConsts.RepositoryWebViewSegue, sender: self)
    return false
  }
}


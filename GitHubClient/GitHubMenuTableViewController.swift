//
//  GitHubMenuTableViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/17/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class GitHubMenuTableViewController: UITableViewController {

  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    startObservingNotifications()
    if let token = KeychainService.loadToken() {
    } else {
      // put this at end of queue so this VC is not considered "detached" when presenting loginVC
      NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        if let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardConsts.LoginViewControllerStoryboardId) as? LoginViewController {
          // present on navigation VC to reduce warning of unbalanced calls to transitions
          self.navigationController?.presentViewController(loginVC, animated: true, completion: nil)
        }
      }
    }
  }
  
  // MARK: Private Helper Methods
  private func requestAccess(stringURL: String) {
    AuthorizationService.accessTokenUsingCodeIn(stringURL) { (data, statusCode, error) -> Void in
      NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        if let error = error {
          AlertOnSessionError.alertPopover(ErrorMessageConsts.nsURLSessionError, withNSError: error, controller: self)
        } else if let data = data {
          var error: NSError?
          let (token, errorDescription) = GitHubParser.tokenFromData(data, error: &error)
          if let token = token {
            KeychainService.saveToken(token.id)
          } else if let error = error {
            AlertOnSessionError.alertPopover(ErrorMessageConsts.nsJSONSerializationError, withNSError: error, controller: self)
          } else if let errorDescription = errorDescription {
            AlertOnSessionError.alertPopover(ErrorMessageConsts.gitHubBadCode, withDescription: errorDescription, controller: self)
          }
        } else if let statusCode = statusCode {
          AlertOnSessionError.alertPopover(NSHTTPURLResponse.localizedStringForStatusCode(statusCode), withStatusCode: statusCode, controller: self)
        }
      }
    }
  }
  
  // MARK: Notification Selector Method
  func appDelegateNeedsOpenURL(notification: NSNotification) {
    println("AppDelegate needs openURL")
    if let userInfo = notification.userInfo, openURL = userInfo[StringConsts.openURLUserInfoKey] as? NSURL, stringURL = openURL.absoluteString {
      requestAccess(stringURL)
    }
  }
  
  deinit {
    stopObservingNotifications()
  }
}

extension GitHubMenuTableViewController {
  func startObservingNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("appDelegateNeedsOpenURL:"), name: StringConsts.openURLNotificationName, object:nil)
  }
  func stopObservingNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: StringConsts.openURLNotificationName, object: nil)
  }
}


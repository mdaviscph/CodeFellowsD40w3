//
//  UserDetailViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/21/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  
  // MARK: Public Properties
  var user: User? {
    didSet {
      updateUI()
    }
  }
  var avatarImage: UIImage? {
    didSet {
      updateUI()
    }
  }
  
  // MARK: Private Properties
  private var jumpToURL: NSURL?
  
  // MARK: IBOutlets
  @IBOutlet weak var textView: UITextView! {    // leave public for setting of background color
    didSet {
      textView.delegate = self
    }
  }
  @IBOutlet weak var imageView: UIImageView!    // must leave public for ToUserDetailAnimationController.animateTransition()
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  // MARK: Private Helper Methods
  private func updateUI() {
    textView?.attributedText = user?.attributedString
    imageView?.image = avatarImage
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == StoryboardConsts.RepositoryWebViewSegue, let webVC = segue.destinationViewController as? WebViewController, jumpToURL = jumpToURL {
      webVC.url = jumpToURL
    }
  }
}

// MARK: User Extension
// how to use attributed text to handle URL linking suggested by various stackover.com posts
extension User {
  var attributedString: NSAttributedString {
    let nl = "\n"
    
    let loginLabel = NSAttributedString(string: UserLabels.login, attributes: [NSForegroundColorAttributeName:UIColor.blackColor()])
    let loginValue = NSAttributedString(string: login+nl, attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
    let htmlURLLabel = NSAttributedString(string: UserLabels.htmlURL, attributes: [NSForegroundColorAttributeName:UIColor.blackColor()])
    let htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: [NSLinkAttributeName:htmlURL])
    let reposURLLabel = NSAttributedString(string: UserLabels.reposURL, attributes: [NSForegroundColorAttributeName:UIColor.blackColor()])
    let reposURLValue = NSAttributedString(string: reposURL+nl, attributes: [NSLinkAttributeName:reposURL])
    
    var result = NSMutableAttributedString(attributedString: loginLabel)
    result.appendAttributedString(loginValue)
    result.appendAttributedString(htmlURLLabel)
    result.appendAttributedString(htmlURLValue)
    result.appendAttributedString(reposURLLabel)
    result.appendAttributedString(reposURLValue)
    return result
  }
}

extension UserDetailViewController: UITextViewDelegate {
  func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    println("push to webView: \(URL.absoluteString!)")
    jumpToURL = URL
    performSegueWithIdentifier(StoryboardConsts.RepositoryWebViewSegue, sender: self.textView)
    return false
  }
}

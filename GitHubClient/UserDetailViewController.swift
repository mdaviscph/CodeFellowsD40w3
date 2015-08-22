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
    
    let loginFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    let urlFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    
    let loginAttributes = [NSFontAttributeName:loginFont, NSForegroundColorAttributeName:UIColor.brownColor()]
    var htmlURLAttributes = [NSFontAttributeName:urlFont,   NSForegroundColorAttributeName:UIColor.darkGrayColor()]
    if let nsHtmlURL = NSURL(string: htmlURL) {
      htmlURLAttributes = [NSFontAttributeName:urlFont, NSLinkAttributeName:nsHtmlURL]
    }
    
    let loginAttrString = NSAttributedString(string: login+nl, attributes: loginAttributes)
    let htmlURLAttrString = NSAttributedString(string: htmlURL+nl, attributes: htmlURLAttributes)

    var result = NSMutableAttributedString(attributedString: loginAttrString)
    result.appendAttributedString(htmlURLAttrString)
    return result
  }
}

// MARK: UITextViewDelegate
extension UserDetailViewController: UITextViewDelegate {
  func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    println("push to webView: \(URL.absoluteString!)")
    jumpToURL = URL
    performSegueWithIdentifier(StoryboardConsts.RepositoryWebViewSegue, sender: self)
    return false
  }
}

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
      textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
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
    
    let fontValue = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    let blackValue = UIColor.blackColor()
    let grayValue = UIColor.grayColor()
    
    let labelAttribute = [NSFontAttributeName:fontValue, NSForegroundColorAttributeName:blackValue]
    let loginLabel = NSAttributedString(string: UserLabels.login, attributes: labelAttribute)
    let htmlURLLabel = NSAttributedString(string: UserLabels.htmlURL, attributes: labelAttribute)
    
    let defaultValueAttribute = [NSFontAttributeName:fontValue, NSForegroundColorAttributeName:grayValue]
    let loginValue = NSAttributedString(string: login+nl, attributes: defaultValueAttribute)
    var htmlURLValue = NSAttributedString()

    if let nsHtmlURL = NSURL(string: htmlURL) {
      htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: [NSFontAttributeName:fontValue, NSLinkAttributeName:nsHtmlURL])
    } else {
      htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: defaultValueAttribute)
    }
    
    var result = NSMutableAttributedString(attributedString: loginLabel)
    result.appendAttributedString(loginValue)
    result.appendAttributedString(htmlURLLabel)
    result.appendAttributedString(htmlURLValue)
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

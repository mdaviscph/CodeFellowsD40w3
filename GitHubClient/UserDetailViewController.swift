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
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  // MARK: Private Helper Methods
  private func updateUI() {
    bodyLabel?.attributedText = user?.attributedString
    imageView?.image = avatarImage
  }
  
  // MARK: IBOutlets
  @IBOutlet private weak var bodyLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!    // must leave public for ToUserDetailAnimationController.animateTransition()
}

// MARK: User Extension
extension User {
  var attributedString: NSAttributedString {
    let nl = "\n"
    
    let loginLabel = NSAttributedString(string: UserLabels.login, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let loginValue = NSAttributedString(string: login+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let htmlURLLabel = NSAttributedString(string: UserLabels.htmlURL, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let reposURLLabel = NSAttributedString(string: UserLabels.reposURL, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let reposURLValue = NSAttributedString(string: reposURL+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    
    var result = NSMutableAttributedString(attributedString: loginLabel)
    result.appendAttributedString(loginValue)
    result.appendAttributedString(htmlURLLabel)
    result.appendAttributedString(htmlURLValue)
    result.appendAttributedString(reposURLLabel)
    result.appendAttributedString(reposURLValue)
    return result
  }
}

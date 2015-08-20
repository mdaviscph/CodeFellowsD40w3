//
//  LoginViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/20/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var explanationLabel: UILabel!
  @IBAction func loginTapped(sender: AnyObject) {
    AuthorizationService.performInitialRequest()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
      explanationLabel.text = StringConsts.loginExplanation
  }
}

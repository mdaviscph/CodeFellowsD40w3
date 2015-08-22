//
//  WebViewController.swift
//  GitHubClient
//
//  Created by mike davis on 8/21/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  // MARK: Public Properties
  var url: NSURL?
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let url = url {
      let webConfig = WKWebViewConfiguration()
      let webView = WKWebView(frame: view.bounds)
      let urlRequest = NSURLRequest(URL: url)
      if let navigation = webView.loadRequest(urlRequest) {
        view.addSubview(webView)
      }
    }
  }
}

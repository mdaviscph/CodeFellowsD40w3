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

  // MARK: Private Properties
  var webView: WKWebView?
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    webView = WKWebView(frame: view.bounds)
    if let url = url, webView = webView {
      let urlRequest = NSURLRequest(URL: url)
      if let navigation = webView.loadRequest(urlRequest) {
        view.addSubview(webView)
      }
    }
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    webView = nil
  }
}

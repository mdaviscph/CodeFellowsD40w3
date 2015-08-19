//
//  GitHubService.swift
//  GitHubClient
//
//  Created by mike davis on 8/17/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class GitHubService {
  
  class func repositoriesForSearchTerm(searchTerm: String, controller: RepositorySearchViewController) {
    let okHTTPStatusCodeRange = 200...203
    let searchURL = self.searchURL(scheme: StringConsts.schemeProtocol, host: StringConsts.domainHost, path: StringConsts.pathEndpoint, query: searchTerm)
    println(searchURL!.absoluteString)
    
    let sessionTask = NSURLSession.sharedSession().dataTaskWithURL(searchURL!) { (data, response, error) -> Void in
      if let error = error {
        AlertOnSessionError.alertPopover(searchURL!.absoluteString, withNSError: error, controller: controller)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        let statusCode = httpResponse.statusCode
        if !(okHTTPStatusCodeRange ~= statusCode) {
          AlertOnSessionError.alertPopover(NSHTTPURLResponse.localizedStringForStatusCode(statusCode), withStatusCode: statusCode, controller: controller)
        } else {
          println(httpResponse)
          var error: NSError?
          var repos = [Repo]()
          if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String:AnyObject], items = rootObject[RepoJSONKeys.items] as? [[String:AnyObject]] {
            for item in items {
              if let repository = Repo(fromJSON: item) {
                repos.append(repository)
              }
            }
          }
          NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            controller.repositories = repos
            controller.tableView.reloadData()
           }
        }
      }
    }
    sessionTask.resume()
  }
  
  // use of NSURLComponents suggested by NSHipster
  private class func searchURL(#scheme: String?, host: String?, path: String?, query: String?) -> NSURL? {
    let components = NSURLComponents()
    components.scheme = scheme
    components.percentEncodedHost = host
    components.percentEncodedPath = path
    components.query = query
    return components.URL
  }
}

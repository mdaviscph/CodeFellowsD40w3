//
//  GitHubService.swift
//  GitHubClient
//
//  Created by mike davis on 8/17/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class GitHubService {
  
  // completion hander probably executed in background queue
  class func repositoriesForSearchTerm(searchTerm: String, completion: (NSData?, Int?, NSError?) -> Void) {
    let okHTTPStatusCodeRange = 200...203
    let searchURL = self.searchURL(scheme: StringConsts.schemeProtocol, host: StringConsts.domainHost, path: StringConsts.pathEndpoint, query: searchTerm)
    
    if let searchURL = searchURL {
      println(searchURL.absoluteString)
      let sessionTask = NSURLSession.sharedSession().dataTaskWithURL(searchURL) { (data, response, error) -> Void in
        if let error = error {
          completion(nil, nil, error)
        } else if let httpResponse = response as? NSHTTPURLResponse {
          let statusCode = httpResponse.statusCode
          if !(okHTTPStatusCodeRange ~= statusCode) {
            completion(nil, statusCode, nil)
          } else {
            println(httpResponse)
            completion(data, nil, nil)
          }
        }
      }
      sessionTask.resume()
    }
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

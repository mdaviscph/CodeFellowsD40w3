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
  class func repositoriesUsingSearchTerm(searchTerm: String, completion: (NSData?, Int?, NSError?) -> Void) {
    let okHTTPStatusCodeRange = 200...203
    if let searchURL = self.searchRepositoryURL(searchTerm), token = KeychainService.loadToken() as? String {
      println(searchURL.absoluteString)
      let request = NSMutableURLRequest(URL: searchURL)
      request.setValue(StringConsts.searchWithTokenName + token, forHTTPHeaderField: StringConsts.authorizationHeader)
      let sessionTask = NSURLSession.sharedSession().dataTaskWithURL(searchURL) { (data, response, error) -> Void in
        if let error = error {
          completion(nil, nil, error)
        } else if let httpResponse = response as? NSHTTPURLResponse {
          let statusCode = httpResponse.statusCode
          if !(okHTTPStatusCodeRange ~= statusCode) {
            completion(nil, statusCode, nil)
          } else {
            //println(httpResponse)
            completion(data, nil, nil)
          }
        }
      }
      sessionTask.resume()
    }
  }
  
  // completion hander probably executed in background queue
  class func usersUsingSearchTerm(searchTerm: String, completion: (NSData?, Int?, NSError?) -> Void) {
    let okHTTPStatusCodeRange = 200...203
    if let searchURL = self.searchUserURL(searchTerm), token = KeychainService.loadToken() as? String {
      println(searchURL.absoluteString)
      let request = NSMutableURLRequest(URL: searchURL)
      request.setValue(StringConsts.searchWithTokenName + token, forHTTPHeaderField: StringConsts.authorizationHeader)
      let sessionTask = NSURLSession.sharedSession().dataTaskWithURL(searchURL) { (data, response, error) -> Void in
        if let error = error {
          completion(nil, nil, error)
        } else if let httpResponse = response as? NSHTTPURLResponse {
          let statusCode = httpResponse.statusCode
          if !(okHTTPStatusCodeRange ~= statusCode) {
            completion(nil, statusCode, nil)
          } else {
            //println(httpResponse)
            completion(data, nil, nil)
          }
        }
      }
      sessionTask.resume()
    }
  }
  
  private class func searchRepositoryURL(searchTerm: String) -> NSURL? {
    let components = NSURLComponents()
    components.scheme = StringConsts.searchScheme
    components.host = StringConsts.searchDomainHost
    components.path = StringConsts.searchRepositoryPathEndpoint
    components.queryItems = [NSURLQueryItem(name: StringConsts.searchQuery, value: searchTerm)]
    return components.URL
  }
  
  private class func searchUserURL(searchTerm: String) -> NSURL? {
    let components = NSURLComponents()
    components.scheme = StringConsts.searchScheme
    components.host = StringConsts.searchDomainHost
    components.path = StringConsts.searchUsersPathEndpoint
    components.queryItems = [NSURLQueryItem(name: StringConsts.searchQuery, value: searchTerm)]
    return components.URL
  }

  // use of NSURLComponents suggested by NSHipster
  private class func nsURLFromComponents(#scheme: String?, host: String?, path: String?, query: String?) -> NSURL? {
    let components = NSURLComponents()
    components.scheme = scheme
    components.host = host
    components.path = path
    components.query = query
    return components.URL
  }
}

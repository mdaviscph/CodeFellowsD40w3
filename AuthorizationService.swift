//
//  AuthorizationService.swift
//  GitHubClient
//
//  Created by mike davis on 8/19/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class AuthorizationService {
  class func performInitialRequest() -> Bool {
    if let url = authorizationURL() where UIApplication.sharedApplication().openURL(url) {
      return true
    }
    return false
  }
  
  class func accessTokenUsingCodeIn(stringURL: String, completion: (NSData?, Int?, NSError?) -> Void) {
    let okHTTPStatusCodeRange = 200...203
    if let accessURL = accessTokenURLFrom(stringURL) {
      let request = NSMutableURLRequest(URL: accessURL)
      request.HTTPMethod = StringConsts.postMethod
      request.setValue(StringConsts.applicationJSON, forHTTPHeaderField: StringConsts.acceptHeader)
      let sessionTask = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
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
  
  private class func authorizationURL() -> NSURL? {
    if let components = NSURLComponents(string: StringConsts.authorizationURL) {
      if StringConsts.authorizationScopeValue.isEmpty {
        components.queryItems = [NSURLQueryItem(name: StringConsts.authorizationClientIdName, value: Keys.ClientId), NSURLQueryItem(name: StringConsts.authorizationRedirectURIName, value: StringConsts.authorizationRedirectURIValue)]
      } else {
        components.queryItems = [NSURLQueryItem(name: StringConsts.authorizationClientIdName, value: Keys.ClientId), NSURLQueryItem(name: StringConsts.authorizationRedirectURIName, value: StringConsts.authorizationRedirectURIValue),           NSURLQueryItem(name: StringConsts.authorizationScopeName, value: StringConsts.authorizationScopeValue)]
      }
      return components.URL
    }
    return nil
  }
  
  private class func accessTokenURLFrom(stringURL: String) -> NSURL? {
    if let components = NSURLComponents(string: stringURL), startingQueryItems = components.queryItems as? [NSURLQueryItem], accessComponents = NSURLComponents(string: StringConsts.accessTokenURL) {
      accessComponents.queryItems = startingQueryItems + [NSURLQueryItem(name: StringConsts.accessTokenClientIdName, value: Keys.ClientId), NSURLQueryItem(name: StringConsts.accessTokenClientSecretName, value: Keys.ClientSecret)]
      return accessComponents.URL
    }
    return nil
  }
}
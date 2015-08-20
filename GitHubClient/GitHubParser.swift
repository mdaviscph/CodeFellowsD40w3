//
//  GitHubParser.swift
//  GitHubClient
//
//  Created by mike davis on 8/19/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

class GitHubParser {
  class func reposFromData(data: NSData, error: NSErrorPointer) -> [Repo]? {
    var repos = [Repo]()
    if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: error) as? [String:AnyObject], items = rootObject[RepoJSONKeys.items] as? [[String:AnyObject]] {
      for item in items {
        if let repository = Repo(fromJSON: item) {
          repos.append(repository)
        }
      }
    }
    return repos.isEmpty ? nil : repos
  }
  class func tokenFromData(data: NSData, error: NSErrorPointer) -> (Token?, String?) {
    if let items = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: error) as? [String:AnyObject] {
      GitHubParser.printSerializedDictionary(items)
      if let token = Token(fromJSON: items) {
        return (token, nil)
      } else if let errorDescription = items[StringConsts.errorDescriptionKey] as?String {
        return (nil, errorDescription)
      } else {
        return (nil, ErrorMessageConsts.gitHubUnknownError)
      }
    }
    return (nil, ErrorMessageConsts.gitHubUnknownError)
  }
  class func printSerializedInfo(rootObject: AnyObject?) {
    if let rootObject = rootObject as? [String:AnyObject] {
      self.printSerializedDictionary(rootObject)
    } else if let rootObject = rootObject as? [AnyObject] {
      self.printSerializedArray(rootObject)
    }
  }
  class func printSerializedDictionary(dictionary: [String:AnyObject]) {
    for (key, value) in dictionary {
      if let value = value as? String {
        println("\(key): \(value)")
      } else if let value = value as? [String:AnyObject] {
        self.printSerializedDictionary(value)
      } else if let value = value as? [AnyObject] {
        self.printSerializedArray(value)
      }
    }
  }
  class func printSerializedArray(array: [AnyObject]) {
    for value in array {
      if let value = value as? String {
        println("\(value)")
      } else if let value = value as? [String:AnyObject] {
        self.printSerializedDictionary(value)
      } else if let value = value as? [AnyObject] {
        self.printSerializedArray(value)
      }
    }
  }
}

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
      if repos.isEmpty { printSerializedInfo(rootObject) }
    }
    return repos.isEmpty ? nil : repos
  }
  class func usersFromData(data: NSData, error: NSErrorPointer) -> [User]? {
    var users = [User]()
    if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: error) as? [String:AnyObject], items = rootObject[UserJSONKeys.items] as? [[String:AnyObject]] {
      for item in items {
        if let user = User(fromJSON: item) {
          users.append(user)
        }
      }
      if users.isEmpty { printSerializedInfo(rootObject) }
    }
    return users.isEmpty ? nil : users
  }
  class func tokenFromData(data: NSData, error: NSErrorPointer) -> (Token?, String?) {
    if let items = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: error) as? [String:AnyObject] {
      if let token = Token(fromJSON: items) {
        return (token, nil)
      } else if let errorDescription = items[StringConsts.errorDescriptionKey] as?String {
        return (nil, errorDescription)
      } else {
        printSerializedDictionary(items)
        return (nil, ErrorMessageConsts.gitHubUnknownError)
      }
    }
    return (nil, ErrorMessageConsts.gitHubUnknownError)
  }
  
  // take any serialized JSON and print to console for debug
  class func printSerializedInfo(rootObject: AnyObject?) {
    if let rootObject = rootObject as? [String:AnyObject] {
      self.printSerializedDictionary(rootObject)
    } else if let rootObject = rootObject as? [AnyObject] {
      self.printSerializedArray(rootObject)
    }
  }
  class func printSerializedDictionary(dictionary: [String:AnyObject]) {
    println("<Dictionary>")
    for (key, value) in dictionary {
      if let value = printPlainOldData(value) {
        println("\(key): \(value)")
      } else if let value = value as? [String:AnyObject] {
        println("\(key):")
        self.printSerializedDictionary(value)
      } else if let value = value as? [AnyObject] {
        println("\(key):")
        self.printSerializedArray(value)
      }
    }
  }
  class func printSerializedArray(array: [AnyObject]) {
    println("<Array>")
    for value in array {
      if let value = printPlainOldData(value) {
        println("\(value)")
      } else if let value = value as? [String:AnyObject] {
        self.printSerializedDictionary(value)
      } else if let value = value as? [AnyObject] {
        self.printSerializedArray(value)
      }
    }
  }
  class func printPlainOldData(pod: AnyObject) -> String? {
    if let pod = pod as? String { return "<String> \(pod)" }
    if let pod = pod as? UInt { return "<UInt> \(pod)" }
    if let pod = pod as? Int { return "<Int> \(pod)" }
    if let pod = pod as? Float { return "<Float> \(pod)" }
    if let pod = pod as? Double { return "<Double> \(pod)" }
    if let pod = pod as? Bool { return "<Bool> \(pod)" }
    return nil
  }
}

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
}

//
//  Repo.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//
// Example from github: https://developer.github.com/v3/search/#search-repositories
//{
//  "total_count": 40,
//  "incomplete_results": false,
//  "items": [
//  {
//  "id": 3081286,
//  "name": "Tetris",
//  "full_name": "dtrupenn/Tetris",
//  "owner": {
//  "login": "dtrupenn",
//  "id": 872147,
//  "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
//  "gravatar_id": "",
//  "url": "https://api.github.com/users/dtrupenn",
//  "received_events_url": "https://api.github.com/users/dtrupenn/received_events",
//  "type": "User"
//  },
//  "private": false,
//  "html_url": "https://github.com/dtrupenn/Tetris",
//  "description": "A C implementation of Tetris using Pennsim through LC4",
//  "fork": false,
//  "url": "https://api.github.com/repos/dtrupenn/Tetris",
//  "created_at": "2012-01-01T00:31:50Z",
//  "updated_at": "2013-01-05T17:58:47Z",
//  "pushed_at": "2012-01-01T00:37:02Z",
//  "homepage": "",
//  "size": 524,
//  "stargazers_count": 1,
//  "watchers_count": 1,
//  "language": "Assembly",
//  "forks_count": 0,
//  "open_issues_count": 0,
//  "master_branch": "master",
//  "default_branch": "master",
//  "score": 10.309712
//  }
//  ]
//}

import Foundation

struct Repo {
  let id: UInt
  let name: String
  let fullName: String
  let descriptionText: String
  let apiURL: String
  let htmlURL: String
  let createdAt: String
  let updatedAt: String
  let language: String

  init?(fromJSON item: [String:AnyObject]) {
    if let id = item[RepoJSONKeys.id] as? UInt, name = item[RepoJSONKeys.name] as? String, fullName = item[RepoJSONKeys.fullName] as? String, description = item[RepoJSONKeys.description] as? String, apiURL = item[RepoJSONKeys.apiURL] as? String, htmlURL = item[RepoJSONKeys.htmlURL] as? String, createdAt = item[RepoJSONKeys.createdAt] as? String, updatedAt = item[RepoJSONKeys.updatedAt] as? String, language = item[RepoJSONKeys.language] as? String {
      self.id = id; self.name = name; self.fullName = fullName; self.descriptionText = description; self.apiURL = apiURL; self.htmlURL = htmlURL; self.createdAt = createdAt; self.updatedAt = updatedAt; self.language = language
    }
    else {
      return nil
    }
  }
}

extension Repo: Printable {
  var description: String {
    let nl = "\n"
    let array = [RepoLabels.name+name, RepoLabels.fullName+fullName, RepoLabels.description+descriptionText, RepoLabels.apiURL+apiURL, RepoLabels.htmlURL+htmlURL, RepoLabels.language+language]
    return array.reduce("") { $0+$1+"\n" }
  }
}

struct RepoLabels {
  static let id = "Id: "
  static let name = "Name: "
  static let fullName = "Full name: "
  static let description = "Description: "
  static let apiURL = "API URL: "
  static let htmlURL = "URL: "
  static let createdAt = "Created at: "
  static let updatedAt = "Updated at: "
  static let language = "Language: "
}

struct RepoJSONKeys {
  static let items = "items"
  static let totalCount = "total_count"
  static let id = "id"
  static let name = "name"
  static let fullName = "full_name"
  static let description = "description"
  static let apiURL = "url"
  static let htmlURL = "html_url"
  static let createdAt = "created_at"
  static let updatedAt = "updated_at"
  static let language = "language"
}

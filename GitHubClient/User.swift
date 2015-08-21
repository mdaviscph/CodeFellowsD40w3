//
//  User.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//
// Example from github: https://developer.github.com/v3/search/#search-users
//{
//  "total_count": 12,
//  "incomplete_results": false,
//  "items": [
//  {
//  "login": "mojombo",
//  "id": 1,
//  "avatar_url": "https://secure.gravatar.com/avatar/25c7c18223fb42a4c6ae1c8db6f50f9b?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
//  "gravatar_id": "",
//  "url": "https://api.github.com/users/mojombo",
//  "html_url": "https://github.com/mojombo",
//  "followers_url": "https://api.github.com/users/mojombo/followers",
//  "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
//  "organizations_url": "https://api.github.com/users/mojombo/orgs",
//  "repos_url": "https://api.github.com/users/mojombo/repos",
//  "received_events_url": "https://api.github.com/users/mojombo/received_events",
//  "type": "User",
//  "score": 105.47857
//  }
//  ]
//}

import Foundation

struct User {
  let login: String
  let id: UInt
  let avatarURL: String
  let apiURL: String
  let htmlURL: String
  let reposURL: String
  
  init?(fromJSON item: [String:AnyObject]) {
    if let login = item[UserJSONKeys.login] as? String, id = item[UserJSONKeys.id] as? UInt, avatarURL = item[UserJSONKeys.avatarURL] as? String, apiURL = item[UserJSONKeys.apiURL] as? String, htmlURL = item[UserJSONKeys.htmlURL] as? String, reposURL = item[UserJSONKeys.reposURL] as? String {
      self.login = login; self.id = id; self.avatarURL = avatarURL; self.apiURL = apiURL; self.htmlURL = htmlURL; self.reposURL = reposURL
    }
    else {
      return nil
    }
  }
}

extension User: Printable {
  var description: String {
    let nl = "\n"
    let array = [UserLabels.login+login, UserLabels.apiURL+apiURL, UserLabels.htmlURL+htmlURL]
    return array.reduce("") { $0+$1+"\n" }
  }
}

struct UserLabels {
  static let login = "Login: "
  static let id = "Id: "
  static let avatarURL = "Avatar URL: "
  static let apiURL = "API URL: "
  static let htmlURL = "URL: "
  static let reposURL = "Repositories URL: "
}

struct UserJSONKeys {
  static let items = "items"
  static let totalCount = "total_count"
  static let login = "login"
  static let id = "id"
  static let avatarURL = "avatar_url"
  static let apiURL = "url"
  static let htmlURL = "html_url"
  static let reposURL = "repos_url"
}


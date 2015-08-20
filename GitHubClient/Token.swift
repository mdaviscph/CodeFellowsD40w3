//
//  Token.swift
//  GitHubClient
//
//  Created by mike davis on 8/19/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

struct Token {
  let id: String

  init?(fromJSON item: [String:AnyObject]) {
    if let id = item[TokenJSONKeys.accessToken] as? String {
      self.id = id
    }
    else {
      return nil
    }
  }
}

struct TokenJSONKeys {
  static let accessToken = "access_token"
}

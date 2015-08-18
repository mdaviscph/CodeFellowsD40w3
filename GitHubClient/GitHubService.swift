//
//  GitHubService.swift
//  GitHubClient
//
//  Created by mike davis on 8/17/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

class GitHubService {
  
  class func repositoriesForSearchTerm(searchTerm: String) {
    
    var biggerImageURL = NSURL(string: stringURL)
    if let pathExtension = biggerImageURL?.pathExtension {
      biggerImageURL = biggerImageURL?.URLByDeletingPathExtension
      if let lastPathComponent = biggerImageURL?.lastPathComponent where lastPathComponent.hasSuffix(TwitterURLConsts.profileImageNormal) {
        biggerImageURL = biggerImageURL?.URLByDeletingLastPathComponent
        var pathComponent = lastPathComponent
        let range = advance(pathComponent.endIndex, -count(TwitterURLConsts.profileImageNormal))..<pathComponent.endIndex
        pathComponent.removeRange(range)
        pathComponent += TwitterURLConsts.profileImageBigger
        biggerImageURL = biggerImageURL?.URLByAppendingPathComponent(pathComponent)
        biggerImageURL = biggerImageURL?.URLByAppendingPathExtension(pathExtension)
        return biggerImageURL
      }
    }

  }
}

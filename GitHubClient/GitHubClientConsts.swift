//
//  GitHubClientConsts.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

struct StringConsts {
  static let authorizationURL = "https://github.com/login/oauth/authorize"
  static let authorizationClientIdName = "client_id"
  static let authorizationRedirectURIName = "redirect_uri"
  static let authorizationRedirectURIValue = "GitHubClient://oauth"
  static let authorizationScopeName = "scope"
  static let authorizationScopeValue = ""
  //  static let authorizationScopeValue = "user,repo"
  static let accessTokenURL = "https://github.com/login/oauth/access_token"
  static let accessTokenClientIdName = "client_id"
  static let accessTokenClientSecretName = "client_secret"
  static let accessTokenCodeName = "code"
  static let searchScheme = "https"
  static let searchDomainHost = "api.github.com"
  static let searchQuery = "q"
  static let searchRepositoryPathEndpoint = "/search/repositories"
  static let searchUsersPathEndpoint = "/search/users"
  static let searchWithTokenName = "token"
  static let errorDescriptionKey = "error_description"
  static let authorizationHeader = "Authorization"
  static let getMethod = "GET"
  static let postMethod = "POST"
  static let applicationJSON = "application/json"
  static let acceptHeader = "Accept"
  static let okAction = "Ok"
  static let loginExplanation = "Grants read-only access to public information (includes public user profile info, public repository info, and gists)"
  //static let loginExplanation = "Grants read/write access to code, commit statuses, collaborators, and deployment statuses for public and private repositories and organizations.\nGrants read/write access to profile info only. Note that this scope includes user:email and user:follow."
  static let openURLNotificationName = "openURLFromGitHub"
  static let openURLUserInfoKey = "openURL"
}
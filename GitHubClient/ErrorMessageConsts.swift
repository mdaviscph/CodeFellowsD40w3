//
//  ErrorMessageConsts.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

struct ErrorMessageConsts {
  static let notSignedIn = "Please sign in and try again."
  static let noAccess = "Please grant access to your account to continue."
  static let noTwitterAccount = "Please create an account to continue."
  static let noConnection = "Cannot connect to server. Please try again later."
  static let badData = "Unable to communicate successfully with server. Please try again later."
  static let noAuthorization = "Access denied by server. Please verify your account."
  static let busyOrServerError = "Service is unavailable. Please try again later."
  static let noNewData = "No new data. Please try again later."
  static let nsURLSessionError = "Internal error in NSURLSession.sharedSession():dataTaskWithURL. Please try again later."
  static let nsJSONSerializationError = "Internal error in NSJSONSerialization.JSONObjectWithData. Please try again later."
}
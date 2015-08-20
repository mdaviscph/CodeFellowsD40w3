//
//  AlertOnSessionError.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class AlertOnSessionError {
  class func alertPopover(title: String?, withNSError error: NSError, controller: UIViewController) {
    let message = error.localizedDescription
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.modalPresentationStyle = .Popover
    alert.popoverPresentationController?.sourceView = controller.view
    alert.popoverPresentationController?.sourceRect = controller.view.frame
    let okAction = UIAlertAction(title: StringConsts.okAction, style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(okAction)
    controller.presentViewController(alert, animated: true, completion: nil)
  }
  class func alertPopover(title: String?, withStatusCode statusCode: Int, controller: UIViewController) {
    let message: String?
    let status = " (\(statusCode))"
    switch statusCode {
    case 200...299:
      message = ErrorMessageConsts.badData + status
    case 300...399:
      message = ErrorMessageConsts.noNewData + status
    case 400...499:
      message = ErrorMessageConsts.noAuthorization + status
    case 500...599:
      message = ErrorMessageConsts.busyOrServerError + status
    default:
      message = ErrorMessageConsts.busyOrServerError + status
    }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.modalPresentationStyle = .Popover
    alert.popoverPresentationController?.sourceView = controller.view
    alert.popoverPresentationController?.sourceRect = controller.view.frame
    let okAction = UIAlertAction(title: StringConsts.okAction, style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(okAction)
    controller.presentViewController(alert, animated: true, completion: nil)
  }
  class func alertPopover(title: String?, withDescription message: String, controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.modalPresentationStyle = .Popover
    alert.popoverPresentationController?.sourceView = controller.view
    alert.popoverPresentationController?.sourceRect = controller.view.frame
    let okAction = UIAlertAction(title: StringConsts.okAction, style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(okAction)
    controller.presentViewController(alert, animated: true, completion: nil)
  }
}

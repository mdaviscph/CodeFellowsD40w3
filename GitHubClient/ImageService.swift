//
//  ImageService.swift
//  GitHubClient
//
//  Created by mike davis on 8/20/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class ImageService {
  
  private lazy var backgroundQueue = NSOperationQueue()
  static let sharedInstance = ImageService()
  
  private init() {
    //backgroundQueue.maxConcurrentOperationCount = 0     // uncomment if you need this for testing
  }
  
  func imageInBackground(stringURL: String, size: CGSize, withRoundedCorner color: UIColor?, completionHandler: (UIImage?) -> Void) {
    if let imageURL = NSURL(string: stringURL) {
      println("download requested: \(stringURL)")
      backgroundQueue.addOperationWithBlock { () -> Void in
        if let data = NSData(contentsOfURL: imageURL), image = UIImage(data: data) {
          let resizedImage = ImageResizer.resize(image, size: size, withRoundedCorner: color)
          completionHandler(resizedImage)
        }
      }
    }
    completionHandler(nil)
  }
}
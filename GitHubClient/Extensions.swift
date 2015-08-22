//
//  Extensions.swift
//  GitHubClient
//
//  Created by mike davis on 8/21/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(_red red: Int, _green green:Int , _blue blue:Int , _alpha alpha: Int) {
    self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha)/255)
  }
}

//
//  UserCell.swift
//  GitHubClient
//
//  Created by mike davis on 8/20/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
  
  var user: User? {
    didSet {
      if let user = user {
        nameLabel.text = user.description
      }
    }
  }
  
  @IBOutlet weak var nameLabel: UILabel!
}

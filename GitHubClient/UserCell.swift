//
//  UserCell.swift
//  GitHubClient
//
//  Created by mike davis on 8/20/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
  
  // MARK: Public Properties
  var user: User? {
    didSet {
      updateUI()
    }
  }
  var avatarImage: UIImage? {
    didSet {
      updateUI()
    }
  }
  
  // MARK: Private Helper Methods
  private func updateUI() {
    nameLabel?.text = user?.login
    imageView?.image = avatarImage
  }
  // MARK: IBOutlets
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!      // must leave public for ToUserDetailAnimationController.animateTransition()
}

//
//  RepositoryCell.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
  
  var repository: Repo? {
    didSet {
      if let repository = repository {
        bodyLabel.text = repository.description
      }
    }
  }
  
  @IBOutlet weak var bodyLabel: UILabel!
}

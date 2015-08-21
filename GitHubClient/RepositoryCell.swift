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
        bodyLabel.attributedText = repository.attributedString
      }
    }
  }
  
  @IBOutlet private weak var bodyLabel: UILabel!
}
extension Repo {
  var attributedString: NSAttributedString {
    let nl = "\n"
    
    let nameLabel = NSAttributedString(string: RepoLabels.name, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let nameValue = NSAttributedString(string: name+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let fullNameLabel = NSAttributedString(string: RepoLabels.fullName, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let fullNameValue = NSAttributedString(string: fullName+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let descriptionLabel = NSAttributedString(string: RepoLabels.description, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let descriptionValue = NSAttributedString(string: descriptionText+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let htmlURLLabel = NSAttributedString(string: RepoLabels.htmlURL, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let languageLabel = NSAttributedString(string: RepoLabels.language, attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
    let languageValue = NSAttributedString(string: language+nl, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    
    var result = NSMutableAttributedString(attributedString: nameLabel)
    result.appendAttributedString(nameValue)
    result.appendAttributedString(fullNameLabel)
    result.appendAttributedString(fullNameValue)
    result.appendAttributedString(descriptionLabel)
    result.appendAttributedString(descriptionValue)
    result.appendAttributedString(htmlURLLabel)
    result.appendAttributedString(htmlURLValue)
    result.appendAttributedString(languageLabel)
    result.appendAttributedString(languageValue)
    return result
  }
}

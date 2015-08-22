//
//  RepositoryCell.swift
//  GitHubClient
//
//  Created by mike davis on 8/18/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
  
  // MARK: Public Properties
  var repository: Repo? {
    didSet {
      updateUI()
    }
  }
  var textViewDelegate: UITextViewDelegate? {
    didSet {
      textView?.delegate = textViewDelegate
    }
  }
  var textViewBackgroundColor: UIColor? {
    didSet {
      textView?.backgroundColor = textViewBackgroundColor
    }
  }
  
  // MARK: Private Helper Methods
  private func updateUI() {
    textView?.attributedText = repository?.attributedString
    textView?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  }
  
  // MARK: IBOutlets
  @IBOutlet weak var textView: UITextView!
}

// MARK: Repo Extension
extension Repo {
  var attributedString: NSAttributedString {
    let nl = "\n"
    
    let fontValue = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    let blackValue = UIColor.blackColor()
    let grayValue = UIColor.grayColor()
    
    let labelAttribute = [NSFontAttributeName:fontValue, NSForegroundColorAttributeName:blackValue]
    let nameLabel = NSAttributedString(string: RepoLabels.name, attributes: labelAttribute)
    let descriptionLabel = NSAttributedString(string: RepoLabels.description, attributes: labelAttribute)
    let languageLabel = NSAttributedString(string: RepoLabels.language, attributes: labelAttribute)
    let htmlURLLabel = NSAttributedString(string: RepoLabels.htmlURL, attributes: labelAttribute)

    let defaultValueAttribute = [NSFontAttributeName:fontValue, NSForegroundColorAttributeName:grayValue]
    let nameValue = NSAttributedString(string: name+nl, attributes: defaultValueAttribute)
    let descriptionValue = NSAttributedString(string: descriptionText+nl, attributes: defaultValueAttribute)
    let languageValue = NSAttributedString(string: language+nl, attributes: defaultValueAttribute)
    var htmlURLValue = NSAttributedString()
    
    if let nsHtmlURL = NSURL(string: htmlURL) {
      htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: [NSFontAttributeName:fontValue, NSLinkAttributeName:nsHtmlURL])
    } else {
      htmlURLValue = NSAttributedString(string: htmlURL+nl, attributes: defaultValueAttribute)
    }
    
    var result = NSMutableAttributedString(attributedString: nameLabel)
    result.appendAttributedString(nameValue)
    result.appendAttributedString(descriptionLabel)
    result.appendAttributedString(descriptionValue)
    result.appendAttributedString(htmlURLLabel)
    result.appendAttributedString(htmlURLValue)
    result.appendAttributedString(languageLabel)
    result.appendAttributedString(languageValue)
    return result
  }
}

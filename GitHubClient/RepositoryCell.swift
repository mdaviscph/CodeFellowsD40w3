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
  
  // MARK: Private Helper Methods
  private func updateUI() {
    textView?.attributedText = repository?.attributedString
  }
  
  // MARK: IBOutlets
  @IBOutlet weak var textView: UITextView! {
    didSet {
      textView.backgroundColor = backgroundColor
      textView.scrollEnabled = false
    }
  }
}

// MARK: Repo Extension
extension Repo {
  var attributedString: NSAttributedString {
    let nl = "\n"
    
    let nameFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    let descriptionFont = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    let languageFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    let urlFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    
    let nameAttributes = [NSFontAttributeName:nameFont, NSForegroundColorAttributeName:UIColor.purpleColor()]
    let descriptionAttributes = [NSFontAttributeName:descriptionFont, NSForegroundColorAttributeName:UIColor.blackColor()]
    let languageAttributes = [NSFontAttributeName:languageFont, NSForegroundColorAttributeName:UIColor.darkGrayColor()]
    var htmlURLAttributes = [NSFontAttributeName:urlFont,   NSForegroundColorAttributeName:UIColor.darkGrayColor()]
    if let nsHtmlURL = NSURL(string: htmlURL) {
      htmlURLAttributes = [NSFontAttributeName:urlFont, NSLinkAttributeName:nsHtmlURL]
    }
    
    let nameAttrString = NSAttributedString(string: name+nl, attributes: nameAttributes)
    let descriptionAttrString = NSAttributedString(string: descriptionText+nl, attributes: descriptionAttributes)
    let languageAttrString = NSAttributedString(string: language+nl, attributes: languageAttributes)
    let htmlURLAttrString = NSAttributedString(string: htmlURL+nl, attributes: htmlURLAttributes)
    
    var result = NSMutableAttributedString(attributedString: nameAttrString)
    result.appendAttributedString(descriptionAttrString)
    result.appendAttributedString(htmlURLAttrString)
    result.appendAttributedString(languageAttrString)
    return result
  }
}

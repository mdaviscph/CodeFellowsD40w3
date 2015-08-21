//
//  ToUserDetailAnimationController.swift
//  GitHubClient
//
//  Created by mike davis on 8/21/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject {
  
}

// MARK: UIViewControllerAnimatedTransitioning
private let animationDuration = 0.4
extension ToUserDetailAnimationController: UIViewControllerAnimatedTransitioning {
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController, toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserDetailViewController {
      let containerView = transitionContext.containerView()
      toVC.view.alpha = 0
      containerView.addSubview(toVC.view)
      if let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as? NSIndexPath, userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as? UserCell {
        let snapshot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
        containerView.addSubview(snapshot)
        userCell.hidden = true
        toVC.view.layoutIfNeeded() // ensure toVC UIImageView is in place
        toVC.imageView.hidden = true
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
          snapshot.frame = toVC.imageView.frame
          toVC.view.alpha = 1
        }, completion: { (finished) -> Void in
          userCell.hidden = false
          toVC.imageView.hidden = false
          snapshot.removeFromSuperview()
          transitionContext.completeTransition(finished)
        })
      }
    }
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return animationDuration
  }
}

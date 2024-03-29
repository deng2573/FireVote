//
//  MainNavigationController.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/13.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpView()
  }
  
  func setUpView() {
    view.backgroundColor = UIColor.themeColor
    navigationBar.isTranslucent = false
    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeNavigationTitleColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
    navigationBar.barTintColor = UIColor.themeColor
    interactivePopGestureRecognizer?.delegate = self
    delegate = self
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if (viewControllers.count > 0) {
      viewController.hidesBottomBarWhenPushed = true
      viewController.setUpDefaultBackButtonItem()
    }
    super.pushViewController(viewController, animated: true)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

extension NavigationController: UINavigationControllerDelegate {
  
}

//
//  MainTabBarControllerViewController.swift
//  PointWorld_tea
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

enum TabTitle: String {
  case home = "maison"
  case my   = "Mon"
}

class TabBarController: UITabBarController {
  
  private lazy var publishButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "vote_publish"), for: .normal)
    button.tap(action: { _ in
      let vc = NavigationController(rootViewController: VotePublishViewController())
      self.present(vc, animated: true, completion: nil)
    })
    return button
  }()
  
  private var itemTitles: [String] = []
  private var itemImages: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tabBar.isUserInteractionEnabled = true
    setupMainTabBar()
  }
  
  func setupMainTabBar() {
    var viewControllers = [UIViewController]()
    viewControllers.append(NavigationController(rootViewController: VoteListViewController()))
    viewControllers.append(UIViewController())
    viewControllers.append(NavigationController(rootViewController: MyViewController()))
    itemTitles.append("投票")
    itemTitles.append("")
    itemTitles.append("我的")
    
    itemImages.append("tab_home")
    itemImages.append("")
    itemImages.append("tab_my")
    
    tabBar.addSubview(publishButton)
    publishButton.snp.makeConstraints({ (make) in
      make.center.equalToSuperview()
      make.size.equalTo(CGSize(width: 70, height: 50))
    })
    
    
    let itemSelectedImages = itemImages.map({title in
      "\(title)_selected"
    })
    
    for i in 0..<itemTitles.count {
      let itemViewController = viewControllers[i]
      itemViewController.tabBarItem = UITabBarItem(title: itemTitles[i],
                                                   image: UIImage(named: itemImages[i])?.withRenderingMode(.alwaysOriginal),
                                                   selectedImage: UIImage(named: itemSelectedImages[i])?.withRenderingMode(.alwaysOriginal))
      itemViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)], for: .selected)
      itemViewController.tabBarItem.tag = i
      if i == 1 {
        itemViewController.tabBarItem.isEnabled = false
      }
    }
    
    self.setViewControllers(viewControllers, animated: false)
    self.selectedIndex = 0
    self.tabBar.barStyle = .default
    self.tabBar.isTranslucent = false
  }
}

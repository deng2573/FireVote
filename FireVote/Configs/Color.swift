//
//  Colors.swift
//  LeMotion
//
//  Created by Deng on 2019/8/30.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

extension UIColor {
  static let themeColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
  
  static let themeNavigationTitleColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
  static let themeViewBackgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
  static let themeTableViewCellBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  
  static let themeTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
  static let themeSubTextColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
}

extension UIImage {
  static let themeImage = UIColor.themeColor.image
}

extension UIFont {
  static let themeTextFont = UIFont.boldSystemFont(ofSize: 16)
  static let themeSubTextFont = UIFont.systemFont(ofSize: 13)
}

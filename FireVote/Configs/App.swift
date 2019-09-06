//
//  AppConfig.swift
//  LeMotion
//
//  Created by Deng on 2019/6/17.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

struct AppConfig {

  static var isDebug: Bool {
    var status: Bool
    #if DEBUG
    status = true
    #else
    status = false
    #endif
    return status
  }

  static var version: String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
  }
}

extension UIFont {
  static func themeFont(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
  }
}

enum FilePath {
  // 存储登录账号密码地址
  struct Account {
    static let userInfo = "UserInfoFile.path"
  }
  // 存储投票列表
  struct Vote {
    static let list = "VoteListFile.path"
  }
}

enum AppKey {
  // 百度翻译
  struct BaiDuAPP {
    static let appId = "20190903000331518"
    static let secret = "rmkZsZp7qcGQVrzTwWGT"
  }
  // 极光
  struct JPushAPP {
    static let key = "65291c20cdb37550ee0d61f8"
  }
}

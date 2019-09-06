//
//  URL.swift
//  LeMotion
//
//  Created by Deng on 2019/4/6.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation

class NetURL {
  static var api: String { return baseURL(domain: "aixiaoyuan-test") + "api/" } // 接口访问 API
  
  static func baseURL(domain: String) -> String {
    return "http://\(domain).zhidiantianxia.cn/"
  }

}

extension NetURL {
  static var translateURL: String { return "https://fanyi-api.baidu.com/api/trans/vip/translate" }
}

extension NetURL {
  static func voteListUrl(type: VoteListType, page: Int) -> String {
    var res_url = ""
    switch type {
    case .vote:
      res_url = api + "vote/pending"
    case .publish:
      res_url = api + "vote/my-pub"
    case .receive:
      res_url = api + "vote/my-join"
    case .manage:
      res_url = api + "vote/manage"
    }
    return res_url + "?page=\(page)"
  }
}

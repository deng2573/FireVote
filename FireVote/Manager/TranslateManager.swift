//
//  TranslateManager.swift
//  FireVote
//
//  Created by Deng on 2019/9/3.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class TranslateManager: NSObject {
  static let from = "zh"
  static let to = "spa"
  static let appid = AppKey.BaiDuAPP.appId
  static let secret = AppKey.BaiDuAPP.secret
  
  // 请求数据
  static func translate(text: String, completion: @escaping ((_ info: TranslateInfo?) -> Void)) {
    let salt = "\(Int(arc4random() % 9999999) + 1)"
    let sign = (appid + text + salt + secret).md5
    
    let parameters = ["q": text, "from": from, "to": to, "appid": appid, "salt": salt, "sign": sign]
    HttpClient.requestObject(method: .get, url: NetURL.translateURL, parameters: parameters, headers: ["": ""], loading: false) { (result: TranslateInfo?) in
      completion(result)
    }
  }
}

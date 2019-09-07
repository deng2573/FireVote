//
//  PWNetwork.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/4.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

class HttpClient: NSObject {

  static let shared = HttpClient()
  
  var uploadRequests: [UploadRequest] = []
  var uploadTasks: [URLSessionUploadTask] = []
  
  private static let manager: SessionManager = initManager()
  
  private static func initManager() -> SessionManager {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForResource = 10
    return SessionManager(configuration: configuration)
  }
  
  private static var isReachable: Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
  
  public static func requestJson(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, loading: Bool = false, callback: @escaping(JSON?) -> Void) {
    // 检测网路状态
    if !isReachable { callback(nil); return }
    // Loading
    if loading { HUD.loading() }
    // 请求
    manager.request(url, method: method, parameters: parameters, headers: headers).responseJSON { response in
      HUD.hide()
      guard let result = response.result.value else {
        callback(nil)
        return
      }
      callback(JSON(result))
    }
  }
  

  public static func requestObject<T: NSObject>(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, loading: Bool = false, callback: @escaping (T?) -> Void) where T: EVReflectable {
    requestJson(method: method, url: url, parameters: parameters, headers: headers, loading: loading) { json in
      guard let data = json?.rawString() else {
        return callback(nil)
      }
      let object = T(json: data)
      return callback(object)
    }
  }
  
  public static func requestObjectList<T: NSObject>(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping ([T]?) -> Void) where T: EVReflectable {
    requestJson(method: method, url: url, parameters: parameters, loading: loading) { json in
      guard let array = json?.arrayValue else {
        return callback(nil)
      }
      let objects = array.map({ json -> T in
      if let data = json.rawString() {
        return T(json: data)
      }
      return T()
      })
      return callback(objects)
    }
  }
}

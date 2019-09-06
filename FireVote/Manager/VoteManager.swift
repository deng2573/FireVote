//
//  VoteManager.swift
//  FireVote
//
//  Created by Deng on 2019/9/3.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

enum VoteListType {
  case vote // 投票
  case manage // 管理
  case publish // 发布
  case receive // 参与
}

class VoteManager: NSObject {
  // 我发布的 我管理的 我收到的 投票列表
  static func voteList(type: VoteListType, page: Int, completion: @escaping ((_ data: VoteListInfoContent) -> Void)) {
    HttpClient.requestObject(method: .get, url: NetURL.voteListUrl(type: type,page: page), parameters: nil, headers: ["axy-token": "eyJhbGciOiJIUzI1NiJ9.eyJuYmYiOjE1NjcxNjA2NzksInBob25lIjoiMTM3ODM1MzI1NzMiLCJleHAiOjE1Njk3NTI2ODF9.9T5eMvSAQo6nDa-bYih1t3ppOZm0Mteqco1FPPb465s","axy-phone": "13783532573"], loading: false) { (result: VoteListData?) in
      guard let result = result else {
        completion(VoteListInfoContent())
        return
      }
      completion(result.data)
    }
  }
  
  static func readVoteListList() -> [VoteListInfo] {
    var voteList: [VoteListInfo] = []
    let voteStringList = UserDefaults.standard.stringArray(forKey: FilePath.Vote.list) ?? []
    for voteString in voteStringList {
      let vote = VoteListInfo(json: voteString)
      voteList.append(vote)
    }
    return voteList
  }
  
  static func writeVoteInfo(voteInfo: VoteListInfo) {
    let standard = UserDefaults.standard
    let vote = voteInfo.toJsonString()
    var voteList: [String] = []
    if let votes = standard.array(forKey: FilePath.Vote.list) {
      voteList = votes as! [String]
    }
    voteList.insert(vote, at: 0)
    standard.set(voteList, forKey: FilePath.Vote.list)
    standard.synchronize()
  }
  
  static func readCover(title: String) -> UIImage {
    let info = UserDefaults.standard.string(forKey: title)
    if let coverString = info, let avatarData = Data(base64Encoded: coverString) {
      return UIImage(data: avatarData)!
    }
    return UIImage()
  }
  
  static func writeCover(image: UIImage, title: String) {
    let coverData = image.pngData()!
    let dataString = coverData.base64EncodedString()
    UserDefaults.standard.set(dataString, forKey: title)
  }
}

extension VoteManager {
  static func calculationVoteForm(item: VoteInfo) {
    let titleText = item.title.yyText(width: screenWidth - 24 * 2, fontSize: 16)
    item.titleHeight = titleText.height + 24 * 2
    
    let subTitleText = item.content.yyText(width: screenWidth - 24 * 2, fontSize: 16)
    item.subTitleHeight = subTitleText.height + 24 * 2
    
    for option in item.voteOptions {
      let titleText = option.content.yyText(width: screenWidth - 45 - (option.fileHeight == 0 ? 45 : 16) )
      option.titleHeight = titleText.height
      option.height = 15 + option.titleHeight + 15 + (option.fileHeight == 0 ? 0 : option.fileHeight + 15)
    }
  }
}

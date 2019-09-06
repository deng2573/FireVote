//
//  VoteInfo.swift
//  FireVote
//
//  Created by Deng on 2019/9/3.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class PWPickerItem: EVObject {
  var url = ""
  var baseUrl = ""
  var type = ""
  var size = 0
  var cover = ""
  var name = ""
  
  var asset: PHAsset?

  var file: PWFileInfo?
  
  override func skipPropertyValue(_ value: Any, key: String) -> Bool {
    return key == "asset" || key == "document" || key == "file" || key == "documentUrl"
  }
}

class PWFileInfo: EVObject {
  var data: Data
  var type: String // 文件后缀
  var pwFileType: String = "" // 文件类型
  
  init(type: String, data: Data) {
    self.type = type
    self.data = data
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
}

class VoteInfo: EVObject {
  var title = ""
  var content = ""
  var type = 1
  var leastOptionNumber = 0
  var mostOptionNumber = 0
  var endTime = ""
  var cover = ""
  var number = 0
  var times = 1
  var organizations: [VoteOrganization] = []
  var voteOptions: [VoteOptionItem] = [VoteOptionItem(), VoteOptionItem()]
  
  var titleHeight: CGFloat = 0
  var subTitleHeight: CGFloat = 0
  var coverImage: UIImage?
  override func skipPropertyValue(_ value: Any, key: String) -> Bool {
    return key == "titleHeight" || key == "subTitleHeight" || key == "coverImage"
  }
  override public func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
    return [(keyInObject: "desc",keyInResource: "description")]
  }
}

class VoteOptionItem: EVObject {
  var content = ""
  var imgs: [VoteOptionFile] = []
  
  var files: [PWPickerItem] = []
  var height: CGFloat = 0
  var titleHeight: CGFloat = 0
  var fileHeight: CGFloat = 0
  var isSelected = false
  
  override func skipPropertyValue(_ value: Any, key: String) -> Bool {
    return key == "height" || key == "titleHeight" || key == "fileHeight" || key == "files"
  }
}

class VoteOrganization: EVObject {
  var organizationId = ""
  var type = ""
}

class VoteOptionFile: EVObject {
  var url = ""
  var type = ""
}

class VoteListData: EVObject {
  var status = -1
  var msg = ""
  var data = VoteListInfoContent()
}

class VoteListInfoContent: EVObject {
  var last = false
  var content = [VoteListInfo]()
}

class VoteListInfo: EVObject {
  var avatar = ""
  var nickname = ""
  var vote = VoteInfo()
  var publish = false
}

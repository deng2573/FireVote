//
//  TranslateInfo.swift
//  FireVote
//
//  Created by Deng on 2019/9/3.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class TranslateInfo: EVObject {
  var from = ""
  var to = ""
  var trans_result: [TranslateResult] = []
}

class TranslateResult: EVObject {
  var src = ""
  var dst = ""
}

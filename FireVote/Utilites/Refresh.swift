//
//  PWRefresh.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/25.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

class PWRefreshHeader: MJRefreshNormalHeader {
  override func prepare() {
    super.prepare()
    lastUpdatedTimeLabel.isHidden = true
    isAutomaticallyChangeAlpha = true
    stateLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    stateLabel.font = UIFont.systemFont(ofSize: 14)
  }
}

class PWRefreshFooter: MJRefreshAutoNormalFooter {
  override func prepare() {
    super.prepare()
    stateLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    stateLabel.font = UIFont.systemFont(ofSize: 14)
    setTitle("我是有底线的~~", for: .noMoreData)
  }
}

extension UITableView {
  func endRefreshing(isNoMoreData state: Bool) {
    if self.mj_footer != nil {
      self.mj_footer.isHidden = false
      state ? self.mj_footer.endRefreshingWithNoMoreData(): self.mj_footer.resetNoMoreData()
    }
    if self.mj_header != nil {
      self.mj_header.endRefreshing()
    }
  }
}

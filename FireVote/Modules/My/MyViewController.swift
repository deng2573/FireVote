//
//  MyViewController.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyViewController: ViewController {
  
  private lazy var headerBackgroundView: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = UIColor.blue
    return view
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = view.backgroundColor
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: MyHeaderTableViewCell.self)
    tableView.register(cellType: MyNormalTableViewCell.self)
    return tableView
  }()
  
  private var cellList = [[StaticTableViewCell]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    loadCellData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  private func setupView() {
    title = "我的"
    view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
    view.addSubview(headerBackgroundView)
    headerBackgroundView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(view)
      make.height.equalTo(1)
    }
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func loadCellData() {
    cellList = [
      [
        StaticTableViewCell(cellType: MyHeaderTableViewCell.self, didSelectPushTo: UpdateUserInfoViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "我的信息", icon: UIImage(), didSelectPushTo: MyMessageViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "反馈与帮助", icon: UIImage(), didSelectPushTo: FeedbackViewController()),
      ],
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "设置", icon: UIImage(), didSelectPushTo: MySettingViewController()),
      ],
    ]
    tableView.reloadData()
  }
  
}

extension MyViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return cellList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellList[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = self.cellList[indexPath.section][indexPath.row]
    
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: item.cellType)
    
    if let cell  = cell as? MyHeaderTableViewCell {
      cell.update()
    }
    
    if let cell  = cell as? MyNormalTableViewCell {
      cell.update(title: item.title)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let item = self.cellList[indexPath.section][indexPath.row]
    if item.cellType == MyHeaderTableViewCell.self {
      return 140
    }
    return 60
  }
  
}

extension MyViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.cellList[indexPath.section][indexPath.row]
    navigationController?.pushViewController(item.didSelectPushTo, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 0.1
    }
    return 16
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerBackgroundView.snp.updateConstraints { (make) in
      make.height.equalTo(-scrollView.contentOffset.y + 1)
    }
  }
}

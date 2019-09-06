//
//  VotePublishViewController.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/8/22.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class VotePublishViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = view.backgroundColor
    tableView.separatorStyle = .none
    tableView.estimatedRowHeight = 0
    tableView.estimatedSectionFooterHeight = 0
    tableView.estimatedSectionHeaderHeight = 0
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: VotePublishTitleCell.self)
    tableView.register(cellType: VotePublishOptionsCell.self)
    tableView.register(cellType: VoteAddOptionCell.self)
    tableView.register(cellType: VotePickerCell.self)
    return tableView
  }()
  
  private lazy var publishButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("发布", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 6
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
      self.publishVote()
    })
    return button
  }()
  
  private var voteInfo = VoteInfo()
  
  private var pickerTypes: [VotePickerType] = [.type, .number, .time, .cover]
  
  private var keyboardRect: CGRect = .zero
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupVoteInfo()
    setupView()
    monitorKeyboard()
  }
  
  private func setupVoteInfo() {
    let endTimeDate = Date().timeIntervalSince1970 + 60 * 60 * 24 + 60 * 10
    let endTime = endTimeDate.dateTime()
    voteInfo.endTime = endTime
  }
  
  private func setupView() {
    title = "发布投票"
    view.backgroundColor = .white
    setUpDefaultBackButtonItem()
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    updateTableView()
    updatePublishButtonState()
  }
  
  private func monitorKeyboard() {
    IQKeyboardManager.shared.enable = true
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: OperationQueue.main) { notification in
      let userInfo = notification.userInfo!
      let keyboardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
      self.keyboardRect = keyboardBounds
    }
  }
  
  private func autoAdjustTo(textView: UITextView) {
    if !textView.isFirstResponder {
      return
    }
    let keyWindow = UIApplication.shared.keyWindow
    let textViewRect = textView.convert(textView.frame, to: keyWindow)
    let textViewMaxY = textViewRect.maxY
    let keyboardMinY = keyboardRect.minY
    let differ = textViewMaxY - keyboardMinY
    let tabViewOffsetY = tableView.contentOffset.y
    
    if differ > 0 {
      tableView.setContentOffset(CGPoint(x: 0, y: tabViewOffsetY + differ), animated: false)
    }
  }
  
  private func updateTableView() {
    VoteManager.calculationVoteForm(item: voteInfo)
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  private func reloadTableView() {
    VoteManager.calculationVoteForm(item: voteInfo)
    tableView.reloadData()
  }

  private func resignCellInputFirstResponder() {
    for cell in tableView.visibleCells {
      for view in cell.contentView.subviews {
        if view.isKind(of: UITextView.self), view.isFirstResponder {
          view.resignFirstResponder()
        }
      }
    }
  }
  
  private func updatePublishButtonState() {
    if cheakFormIsOk() {
      publishButton.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
      publishButton.isEnabled = true
    } else {
      publishButton.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
      publishButton.isEnabled = false
    }
  }
  
  private func cheakFormIsOk() -> Bool {
    if voteInfo.title.isEmpty {
      return false
    }
    if voteInfo.voteOptions.count < 2 {
      return false
    }
    for option in voteInfo.voteOptions {
      if option.content.isEmpty {
        return false
      }
    }
    return true
  }
  
  private func publishVote() {
    if voteInfo.title.isEmpty {
      HUD.show(text: "请编辑题目名称")
      return
    }
    if voteInfo.voteOptions.count < 2 {
      HUD.show(text: "至少两个选项")
      return
    }
    for option in voteInfo.voteOptions {
      if option.content.isEmpty {
        HUD.show(text: "选项内容不能为空")
        return
      }
    }
    if voteInfo.coverImage == nil {
      HUD.show(text: "请选择封面")
      return
    }
    
    if let image = voteInfo.coverImage {
      let coverData = image.pngData()!
      let dataString = coverData.base64EncodedString()
      voteInfo.cover = dataString
    }
    
    let voteListInfo = VoteListInfo()
    
    if let userInfo = UserInfoManager.readUserInfo() {
      voteListInfo.avatar = userInfo.avatar
      voteListInfo.nickname = userInfo.nickName
    } 
    
    if voteListInfo.avatar.isEmpty {
      voteListInfo.avatar = "avatar"
    }
    if voteListInfo.nickname.isEmpty {
      voteListInfo.nickname = "Votación ligera"
    }
    voteListInfo.vote = voteInfo
    voteListInfo.publish = true
    VoteManager.writeVoteInfo(voteInfo: voteListInfo)
    HUD.loading()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      HUD.show(text: "发布成功")
      self.dismiss(animated: true, completion: nil)
    }
  }
}

extension VotePublishViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 2
    } else if section == 1 {
      return voteInfo.voteOptions.count + 1
    } else {
      return pickerTypes.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      
      let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VotePublishTitleCell.self)
      cell.isSubTitle = indexPath.row == 1
      cell.input = indexPath.row == 0 ? voteInfo.title : voteInfo.content
      cell.updateTextView = { textView in
        if indexPath.row == 0 {
          self.voteInfo.title = textView.text
        } else {
          self.voteInfo.content = textView.text
        }
        self.updatePublishButtonState()
        self.updateTableView()
      }
      return cell
    } else if indexPath.section == 1 {
      if indexPath.row == voteInfo.voteOptions.count {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VoteAddOptionCell.self)
        cell.addAction = {
          self.resignCellInputFirstResponder()
          self.voteInfo.voteOptions.append(VoteOptionItem())
          self.reloadTableView()
        }
        return cell
      }

      let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VotePublishOptionsCell.self)
      let option = voteInfo.voteOptions[indexPath.row]
      cell.update(info: option)
      cell.updateTextView = { textView in
        option.content = textView.text
        self.updatePublishButtonState()
        self.updateTableView()
        self.autoAdjustTo(textView: textView)
      }
      cell.updatePickerView = { height, itemList in
        option.fileHeight = height
        option.files = itemList
        self.reloadTableView()
      }
      cell.deleteAction = {
        self.resignCellInputFirstResponder()
        let alert = UIAlertController(title: "", message: "确定要删除此选项吗?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (alert) in
          self.tableView.reloadData()
        }
        let confirm = UIAlertAction(title: "确定", style: .default) { (alert) in
          self.voteInfo.voteOptions.remove(at: indexPath.row)
          self.reloadTableView()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
      }
      return cell
    } else {
      let pickerType = pickerTypes[indexPath.row]
      let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VotePickerCell.self)
      cell.changeType = {
        if self.voteInfo.type == 0 {
          self.pickerTypes = [.type, .min, .max, .number, .time, .cover]
        } else {
          self.pickerTypes = [.type, .number, .time, .cover]
        }
        tableView.reloadData()
      }
      cell.update(type: pickerType, info: voteInfo)
      cell.updateData = {
        self.updatePublishButtonState()
      }
      return cell
    }
  }
}

extension VotePublishViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return indexPath.row == 0 ? voteInfo.titleHeight : voteInfo.subTitleHeight
    } else if indexPath.section == 1 {
      if indexPath.row == voteInfo.voteOptions.count {
        return 80
      }
      let option = voteInfo.voteOptions[indexPath.row]
      return option.height
    } else {
      let pickerType = pickerTypes[indexPath.row]
      return pickerType == .cover ? 145 : 50
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    if section != 2 {
      return view
    }
    view.addSubview(publishButton)
    publishButton.snp.makeConstraints { make in
      make.top.equalTo(24)
      make.left.equalTo(8)
      make.right.equalTo(-8)
      make.height.equalTo(48)
    }
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if section == 2 {
      return 80
    }
    return 0.1
  }
}

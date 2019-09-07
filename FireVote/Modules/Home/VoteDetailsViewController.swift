//
//  VoteDetailsViewController.swift
//  FireVote
//
//  Created by Deng on 2019/9/4.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class VoteDetailsViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = view.backgroundColor
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(cellType: VoteOptionCell.self)
    return tableView
  }()
  
  private lazy var publishButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Votar", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 6
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
      HUD.loading()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        HUD.show(text: "Gracias por tu voto.")
      }
    })
    return button
  }()
  
  var optionList: [VoteOptionItem] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = "Detalles de votación"
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    view.addSubview(publishButton)
    publishButton.snp.makeConstraints({ (make) in
      make.bottom.equalTo(-8)
      make.left.equalTo(16)
      make.right.equalTo(-16)
      make.height.equalTo(48)
    })
  }
}

extension VoteDetailsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return optionList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let info = self.optionList[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VoteOptionCell.self)
    cell.update(text: info.content, isLast: indexPath.row == optionList.count - 1, isSelect: info.isSelected)
    return cell
  }
}

extension VoteDetailsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return  60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let info = self.optionList[indexPath.row]
    for info1 in self.optionList {
      info1.isSelected = false
    }
    info.isSelected = true
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
}


class VoteOptionCell: UITableViewCell {
  private lazy var checkButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "vote_no_selected"), for: .normal)
    button.setImage(#imageLiteral(resourceName: "vote_selected"), for: .selected)
    return button
  }()
  
  private lazy var titleLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
    return lineView
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupView()
  }
  
  private func setupView() {
//    contentView.backgroundColor = UIColor.themeViewBackgroundColor
    contentView.addSubview(checkButton)
    checkButton.snp.makeConstraints({ (make) in
      make.left.equalTo(16)
      make.size.equalTo(CGSize(width: 25, height: 25))
      make.centerY.equalToSuperview()
    })
    
    contentView.addSubview(titleLable)
    titleLable.snp.makeConstraints({ (make) in
      make.centerY.equalToSuperview()
      make.left.equalTo(45)
      make.right.equalTo(-16)
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.bottom.left.right.equalToSuperview()
      make.height.equalTo(0.5)
    })
  }
  
  func update(text: String, isLast: Bool, isSelect: Bool) {
    titleLable.text = text
    checkButton.isSelected = isSelect
    lineView.isHidden = isLast
  }
}

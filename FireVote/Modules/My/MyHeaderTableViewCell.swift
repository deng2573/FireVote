//
//  MyHeaderTabViewCell.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyHeaderTableViewCell: UITableViewCell {

  private lazy var contentBackgroundView: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = UIColor.themeTableViewCellBackgroundColor
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.borderColor = view.layer.shadowColor
    view.layer.borderWidth = 0.01
    view.layer.cornerRadius = 5
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = .zero
    return view
  }()
  
  private lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 66 / 2
    return imageView
  }()
  
  private lazy var nameLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = UIColor.themeTextColor
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var accountLable: UILabel = {
    let label = UILabel()
    label.text = "ID:  HHI0031"
    label.textColor = UIColor.themeTextColor
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()

  private lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    return lineView
  }()
  
  private lazy var moreLable: UILabel = {
    let label = UILabel()
    label.text = "Más información"
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font =  UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  private lazy var arrowImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "cell_arrow"))
    return imageView
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
    backgroundColor = UIColor.themeTableViewCellBackgroundColor
    
    contentView.addSubview(nameLable)
    nameLable.snp.makeConstraints({ (make) in
      make.top.equalTo(15)
      make.left.equalTo(25)
    })
    
    contentView.addSubview(accountLable)
    accountLable.snp.makeConstraints({ (make) in
      make.top.equalTo(nameLable.snp.bottom).offset(25)
      make.left.equalTo(nameLable)
    })
    
    contentView.addSubview(avatarImageView)
    avatarImageView.snp.makeConstraints({ (make) in
      make.top.equalTo(5)
      make.right.equalTo(-20)
      make.size.equalTo(CGSize(width: 66, height: 66))
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.left.equalTo(16)
      make.right.equalTo(-16)
      make.top.equalTo(accountLable.snp.bottom).offset(20)
      make.height.equalTo(0.5)
    })
    
    contentView.addSubview(moreLable)
    moreLable.snp.makeConstraints({ (make) in
      make.left.equalTo(nameLable)
      make.bottom.equalTo(lineView.snp.bottom).offset(30)
    })
    
    contentView.addSubview(arrowImageView)
    arrowImageView.snp.makeConstraints({ (make) in
      make.centerY.equalTo(moreLable)
      make.right.equalTo(-20)
      make.size.equalTo(CGSize(width: 20, height: 20))
    })
  }
  
  func update() {
    if let userInfo = UserInfoManager.readUserInfo() {
      nameLable.text = userInfo.nickName.isEmpty ? "No establecido" : userInfo.nickName
      if !userInfo.avatar.isEmpty, let avatarData = Data(base64Encoded: userInfo.avatar) {
        avatarImageView.image = UIImage(data: avatarData)
      }
    }
  }
}

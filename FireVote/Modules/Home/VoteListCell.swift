//
//  VoteListCell.swift
//  PointWorld_tea
//
//  Created by hao on 2019/8/26.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit

class VoteListCell: UITableViewCell {
  
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
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    return imageView
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .left
    return label
  }()
  
  private lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .left
    return label
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var coverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    return imageView
  }()
  
  private lazy var voteBtn: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    btn.setTitle("立即投票", for: .normal)
    btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    btn.layer.cornerRadius = 8
    btn.layer.masksToBounds = true
    btn.isUserInteractionEnabled = false
    return btn
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupView()
  }
  
  func setupView() {
    contentView.backgroundColor = UIColor.themeViewBackgroundColor
    contentView.addSubview(contentBackgroundView)
    contentBackgroundView.snp.makeConstraints { (make) in
      make.edges.equalTo(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    contentView.addSubview(avatarImageView)
    avatarImageView.snp.makeConstraints { make in
      make.left.equalTo(32)
      make.top.equalTo(10)
      make.size.equalTo(CGSize(width: 40, height: 40))
    }
    
    contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { make in
      make.left.equalTo(avatarImageView.snp.right).offset(6)
      make.top.equalTo(avatarImageView)
    }
    
    contentView.addSubview(timeLabel)
    timeLabel.snp.makeConstraints { make in
      make.left.equalTo(nameLabel)
      make.top.equalTo(nameLabel.snp.bottom).offset(6)
    }
    
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(avatarImageView.snp.bottom).offset(6)
      make.left.equalTo(avatarImageView)
      make.right.equalTo(-32)
    }
    
    contentView.addSubview(contentLabel)
    contentLabel.snp.makeConstraints { (make) in
      make.top.equalTo(titleLabel.snp.bottom).offset(6)
      make.left.equalTo(titleLabel)
      make.right.equalTo(titleLabel)
    }
    
    contentView.addSubview(coverImageView)
    coverImageView.snp.makeConstraints { (make) in
      make.top.equalTo(contentLabel.snp.bottom).offset(6)
      make.left.right.equalTo(titleLabel)
      make.height.equalTo(200)
    }
    
    contentView.addSubview(voteBtn)
    voteBtn.snp.makeConstraints { (make) in
      make.top.equalTo(coverImageView.snp.bottom).offset(24)
      make.left.equalTo(40)
      make.right.equalTo(-40)
      make.height.equalTo(48)
      make.bottom.equalTo(-25)
    }
  }
  
  func update(info: VoteListInfo) {
    nameLabel.text = info.nickname
    timeLabel.text = info.vote.endTime
    titleLabel.text = info.vote.title
    contentLabel.text = info.vote.content
    if let imageData = Data(base64Encoded: info.avatar) {
      avatarImageView.image = UIImage(data: imageData)
    } else {
      avatarImageView.image = UIImage(named: info.avatar)
    }
    if let imageData = Data(base64Encoded: info.vote.cover) {
      coverImageView.image = UIImage(data: imageData)
    }else {
      coverImageView.image = UIImage(named: info.vote.cover)
    }
  }
  
}

//
//  AssetPickerCell.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/7/16.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit

class AssetPickerCell: UICollectionViewCell {
  
  var deleteAction: (() -> Void)?
  
  lazy var assetImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 2
    return imageView
  }()
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "vote_del_img"), for: .normal)

    return button
  }()
  
  private lazy var playButton: UIButton = {
    let button = UIButton(type: .custom)
    button.isHidden = true

    button.isUserInteractionEnabled = false
    return button
  }()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  private func setUpView() {
    contentView.addSubview(assetImageView)
    assetImageView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 7))
    })
    
    contentView.addSubview(deleteButton)
    deleteButton.snp.makeConstraints({ (make) in
      make.centerX.equalTo(assetImageView.snp.right)
      make.centerY.equalTo(assetImageView.snp.top)
      make.size.equalTo(CGSize(width: 13, height: 13))
    })
    
    contentView.addSubview(playButton)
    playButton.snp.makeConstraints({ (make) in
      make.center.equalTo(assetImageView)
      make.size.equalTo(CGSize(width: 25, height: 25))
    })
  }
  
  func update(info: PWPickerItem) {
    let manager = TZImageManager.default()
    if let asset = info.asset {
      manager?.getPhotoWith(asset, completion: { image, info, success in
        self.assetImageView.image = image
      })
    }
  }
}

class AssetAddCell: UICollectionViewCell {
  
  private lazy var addImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "vote_add_img"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 2
    return imageView
  }()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  private func setUpView() {
    contentView.addSubview(addImageView)
    addImageView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 7))
    })
  }
}

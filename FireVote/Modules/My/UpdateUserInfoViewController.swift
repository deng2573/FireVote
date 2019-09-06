//
//  UpdateUserInfoViewController.swift
//  LeMotion
//
//  Created by Deng on 2019/4/4.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import TZImagePickerController

class UpdateUserInfoViewController: ViewController {
  
  private var avatarImage: UIImage?
  
  private var name: String {
    return nameTextField.text ?? ""
  }
  
  private lazy var backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.themeTableViewCellBackgroundColor
    return view
  }()
  
  private lazy var avatarButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.masksToBounds = true
    button.layer.borderWidth = 0.1
    button.layer.cornerRadius = 40
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.tap(action: { _ in
      self.showPickerController()
    })
    button.setImage(#imageLiteral(resourceName: "avatar"), for: .normal)
    return button
  }()
  
  private lazy var tipsLable: UILabel = {
    let label = UILabel()
    label.text = "点击修改头像"
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 12)
    return label
  }()
  
  private lazy var nameTextField: UITextField = {
    let textField = UITextField(frame: .zero)
    textField.layer.cornerRadius = 10
    textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
    textField.tintColor = .white
    textField.layer.borderWidth = 1
    textField.textAlignment  = .center
    textField.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
    textField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
    let attributes: [NSAttributedString.Key : Any] = [
      .foregroundColor: #colorLiteral(red: 0.662745098, green: 0.6431372549, blue: 0.7058823529, alpha: 1),
      .font : textField.font!
    ]
    textField.attributedPlaceholder = NSAttributedString(string: "输入", attributes: attributes)
    return textField
  }()
  
  private lazy var saveButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 22
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitle("保存", for: .normal)
    button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button.tap(action: { _ in
      self.gotoModify()
    })
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = "个人信息"
    view.addSubview(backgroundView)
    
    backgroundView.snp.makeConstraints({ (make) in
      make.top.equalToSuperview().offset(80)
      make.left.right.equalToSuperview()
      make.height.equalTo(160)
    })
    
    view.addSubview(avatarButton)
    avatarButton.snp.makeConstraints({ (make) in
      make.centerY.equalTo(backgroundView.snp.top)
      make.centerX.equalToSuperview()
      make.size.equalTo(CGSize(width: 80, height: 80))
    })
    
    view.addSubview(tipsLable)
    tipsLable.snp.makeConstraints({ (make) in
      make.top.equalTo(avatarButton.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
    })
    
    view.addSubview(nameTextField)
    nameTextField.snp.makeConstraints({ (make) in
      make.top.equalTo(tipsLable.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
      make.size.equalTo(CGSize(width: 250, height: 40))
    })
    
    view.addSubview(saveButton)
    saveButton.snp.makeConstraints({ (make) in
      make.top.equalTo(backgroundView.snp.bottom).offset(60)
      make.centerX.equalToSuperview()
      make.left.equalTo(20)
      make.right.equalTo(-20)
      make.height.equalTo(44)
    })
    
    if let userInfo = UserInfoManager.readUserInfo() {
      nameTextField.text = userInfo.nickName
      if !userInfo.avatar.isEmpty, let avatarData = Data(base64Encoded: userInfo.avatar) {
        avatarButton.setImage(UIImage(data: avatarData), for: .normal)
      }
    }
  }
  
  private func showPickerController() {
    let imgPicker = TZImagePickerController(maxImagesCount: 1, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)
    imgPicker?.allowTakePicture = true
    imgPicker?.allowPickingGif = false
    imgPicker?.allowPickingOriginalPhoto = true
    imgPicker?.allowCrop = true
    imgPicker?.needCircleCrop = false
    imgPicker?.needShowStatusBar = true
    
    imgPicker?.didFinishPickingPhotosHandle = { photos, assets, isSelectOriginalPhoto in
      self.avatarImage = photos?.first
      if let image = self.avatarImage {
        self.avatarButton.setImage(image, for: .normal)
      }
    }
    present(imgPicker!, animated: true, completion: nil)
  }
  
  private func gotoModify() {
    if name.isEmpty {
      HUD.show(text: "保存成功")
      return
    }
    
    let userInfo = UserInfo()
    userInfo.nickName = name
    if let image = self.avatarImage {
      let avatarData = image.pngData()!
      let dataString = avatarData.base64EncodedString()
      userInfo.avatar = dataString
    }
    UserInfoManager.writeUserInfo(userInfo: userInfo)
    navigationController?.popViewController(animated: true)
  }
}





//
//  VotePublishCell.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/8/22.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit
import QMUIKit
let InsLogFillAssetViewHeight: CGFloat = (screenWidth - 32 - 4 * 8) / 5

class VotePublishTitleCell: UITableViewCell {
  
  var updateTextView: ((UITextView) -> Void)?
  
  var isSubTitle: Bool = false {
    willSet {
      if newValue {
        textLimit = 800
        placeholderLable.text = "Ingrese una descripción de votación "
      } else {
        textLimit = 32
        placeholderLable.text = "Título (dentro de 32 palabras)"
      }
    }
  }
  
  var input: String {
    set {
      textView.text = newValue
      placeholderLable.isHidden = textView.text.count != 0
    }
    get {
      return textView.text ?? ""
    }
  }

  private var textLimit = 32
  
  private lazy var textView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    textView.isScrollEnabled = false
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    textView.delegate = self
    return textView
  }()
  
  private lazy var placeholderLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
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
    contentView.addSubview(textView)
    textView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
    })
    
    contentView.addSubview(placeholderLable)
    placeholderLable.snp.makeConstraints({ (make) in
      make.top.equalTo(textView)
      make.left.equalTo(textView.snp.left)
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalTo(contentView)
      make.height.equalTo(0.5)
    })
  }
}

extension VotePublishTitleCell: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    placeholderLable.isHidden = textView.text.count != 0
    updateTextView?(self.textView)
  }
}


class VotePublishOptionsCell: UITableViewCell {
  
  var updateTextView: ((UITextView) -> Void)?
  var updatePickerView: ((CGFloat, [PWPickerItem]) -> Void)?
  
  var deleteAction: (() -> Void)?
  
  private var textLimit = 200
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "vote_del"), for: .normal)
    button.tap(action: { _ in
      self.deleteAction?()
    })
    return button
  }()
  
  private lazy var textView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.font = UIFont.systemFont(ofSize: 14)
    textView.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    textView.isScrollEnabled = false
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    textView.delegate = self
    return textView
  }()
  
  private lazy var placeholderLable: UILabel = {
    let label = UILabel()
    label.text = "Por favor ingrese el contenido de la opción"
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font =  UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  private lazy var imageButton: UIButton = {
    let button = UIButton(type: .custom)
    button.contentMode = .scaleAspectFill
    button.setImage(#imageLiteral(resourceName: "vote_insert"), for: .normal)
    button.tap(action: { _ in
      self.selectPictures()
    })
    return button
  }()

  private lazy var assetView: AssetPickerView = {
    let assetView = AssetPickerView(frame: CGRect(x: 16, y: 0, width: screenWidth - 32, height: InsLogFillAssetViewHeight), interitemSpacing: 8, rowNumber: 5)
    assetView.isHidden = true
    return assetView
  }()
  
  private lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
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
    contentView.addSubview(deleteButton)
    deleteButton.snp.makeConstraints({ (make) in
      make.top.equalTo(15)
      make.left.equalTo(16)
      make.size.equalTo(CGSize(width: 20, height: 20))
    })
    
    contentView.addSubview(textView)
    textView.snp.makeConstraints({ (make) in
      make.top.equalTo(15)
      make.left.equalTo(45)
      make.right.equalTo(-45)
    })
    
    contentView.addSubview(placeholderLable)
    placeholderLable.snp.makeConstraints({ (make) in
      make.top.equalTo(textView)
      make.left.equalTo(textView.snp.left)
    })
    
    contentView.addSubview(imageButton)
    imageButton.snp.makeConstraints({ (make) in
      make.top.equalTo(textView)
      make.right.equalTo(-16)
      make.size.equalTo(CGSize(width: 25, height: 25))
    })
    
    contentView.addSubview(assetView)
    assetView.snp.makeConstraints({ (make) in
      make.bottom.equalTo(-15)
      make.left.equalTo(16)
      make.right.equalTo(-16)
      make.height.equalTo(InsLogFillAssetViewHeight)
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalTo(contentView)
      make.height.equalTo(0.5)
    })
  }
  
  private func selectPictures() {
    assetView.presentPickerController()
  }
  
  func update(info: VoteOptionItem) {
    textView.text = info.content
    placeholderLable.isHidden = textView.text.count != 0
    
    assetView.update(list: info.files, refresh: { height, itemList in
      let viewH = itemList.isEmpty ? 0 : height
      self.updatePickerView?(viewH, itemList)
    })
    assetView.isHidden = info.files.isEmpty
    imageButton.isHidden = !assetView.isHidden
    let viewH = assetView.isHidden ? 0 : info.fileHeight
    assetView.snp.updateConstraints({ (make) in
      make.height.equalTo(viewH)
    })
    textView.snp.updateConstraints({ (make) in
      make.right.equalTo(self.imageButton.isHidden ? -16: -45)
    })
  }
}

extension VotePublishOptionsCell: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    placeholderLable.isHidden = textView.text.count != 0
    self.updateTextView?(self.textView)
  }
}


class VoteAddOptionCell: UITableViewCell {
  
  var addAction: (() -> Void)?
  
  private lazy var addButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "vote_add"), for: .normal)
    button.isUserInteractionEnabled = false
    
    return button
  }()
  
  private lazy var titleLable: UILabel = {
    let label = UILabel()
    label.text = "Agregar opción"
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font =  UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var tipsLable: UILabel = {
    let label = UILabel()
    label.text = "No hay límite para esta opción."
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.font =  UIFont.systemFont(ofSize: 10)
    return label
  }()
  
  private lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    return lineView
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupView()
    addTapGestureTarget(self, action: #selector(addOption))
  }
  
  private func setupView() {
    contentView.addSubview(addButton)
    addButton.snp.makeConstraints({ (make) in
      make.left.equalTo(18)
      make.top.equalTo(16)
      make.size.equalTo(CGSize(width: 20, height: 20))
    })
    
    contentView.addSubview(titleLable)
    titleLable.snp.makeConstraints({ (make) in
      make.centerY.equalTo(addButton)
      make.left.equalTo(addButton.snp.right).offset(10)
    })
    
    contentView.addSubview(tipsLable)
    tipsLable.snp.makeConstraints({ (make) in
      make.top.equalTo(addButton.snp.bottom).offset(15)
      make.left.equalTo(addButton)
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalTo(contentView)
      make.height.equalTo(0.5)
    })
  }
  
  @objc private func addOption() {
    addAction?()
  }
}

enum VotePickerType {
  case type
  case min
  case max
  case time
  case number
  case member
  case cover
}

class VotePickerCell: UITableViewCell {
  
  var changeType: (() -> Void)?
  
  var updateData: (() -> Void)?
  
  private var info: VoteInfo!
  private var type: VotePickerType = .type
  
  private lazy var titleLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var valueLable: UILabel = {
    let label = UILabel()
    label.text = "Por favor elija"
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var arrowView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "vote_right_icon"))
    return imageView
  }()
  
  private lazy var coverView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private lazy var coverDeleteButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "vote_del_img"), for: .normal)
    button.tap(action: { _ in
      self.info.coverImage = nil
      self.update(type: self.type, info: self.info)
    })
    return button
  }()
  
  private lazy var tipsLable: UILabel = {
    let label = UILabel()
    label.text = "Establecer una portada relacionada con el tema"
    label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  
  private lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    return lineView
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setUpView()
  }
  
  private func setUpView() {
    
    contentView.addSubview(titleLable)
    titleLable.snp.makeConstraints({ (make) in
      make.left.equalTo(16)
      make.right.equalTo(contentView.snp.centerX).offset(-5)
      make.centerY.equalToSuperview()
    })
    
    contentView.addSubview(arrowView)
    arrowView.snp.makeConstraints({ (make) in
      make.right.equalTo(-16)
      make.centerY.equalToSuperview()
      make.size.equalTo(CGSize(width: 7, height: 14))
    })
    
    contentView.addSubview(valueLable)
    valueLable.snp.makeConstraints({ (make) in
      make.left.equalTo(contentView.snp.centerX).offset(5)
      make.right.equalTo(arrowView.snp.left).offset(-8)
      make.centerY.equalToSuperview()
    })
    
    contentView.addSubview(coverView)
    coverView.snp.makeConstraints({ (make) in
      make.left.equalTo(180)
      make.centerY.equalTo(titleLable)
      make.size.equalTo(CGSize(width: 120, height: 68))
    })
    
    contentView.addSubview(coverDeleteButton)
    coverDeleteButton.snp.makeConstraints({ (make) in
      make.centerX.equalTo(coverView.snp.right)
      make.centerY.equalTo(coverView.snp.top)
      make.size.equalTo(CGSize(width: 15, height: 15))
    })
    
    contentView.addSubview(tipsLable)
    tipsLable.snp.makeConstraints({ (make) in
      make.top.equalTo(coverView.snp.bottom).offset(16)
      make.left.equalTo(titleLable)
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.left.equalTo(16)
      make.right.equalTo(-16)
      make.bottom.equalToSuperview()
      make.height.equalTo(0.5)
    })
    addTapGestureTarget(self, action: #selector(showPicker))
  }
  
  func update(type: VotePickerType, info: VoteInfo) {
    self.info = info
    self.type = type
    var title = ""
    var value = ""
    
    switch type {
      case .type:
        title = "Tipo de votación"
        value = info.type == 0 ? "Selección múltiple" : "Radio"
      case .min:
        title = "Cantidad mínima de opciones"
        value = info.leastOptionNumber == 0 ? "Ilimitado" : "\(info.leastOptionNumber)"
      case .max:
        title = "Número máximo de opciones."
        value = info.mostOptionNumber == 0 ? "Ilimitado" : "\(info.mostOptionNumber)"
      case .time:
        title = "Hora final"
        value = info.endTime.isEmpty ? "No seleccionado" : info.endTime
      case .number:
        title = "Numero de votos"
        value = info.times == 1 ? "Solo una vez por persona" : "Solo una vez por persona"
      case .member:
        title = ""
        value = info.number == 0 ? "未选择" : "\(info.number)人"
      case .cover:
        title = "Ajuste de la cubierta"
        if let image = info.coverImage {
          coverView.image = image
        } else {
          coverView.image = #imageLiteral(resourceName: "cover_add")
        }
      }
    valueLable.textColor = value == "No seleccionado" ? #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) : #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    titleLable.text = title
    valueLable.text = value
    coverView.isHidden = type != .cover
    coverDeleteButton.isHidden = info.coverImage == nil
    tipsLable.isHidden = type != .cover
    valueLable.isHidden = type == .cover
    arrowView.isHidden = type == .cover
    lineView.isHidden = type == .cover
    if type == .cover {
      titleLable.snp.remakeConstraints({ (make) in
        make.left.equalTo(16)
        make.top.equalTo(57)
      })
    } else {
      titleLable.snp.remakeConstraints({ (make) in
        make.left.equalTo(16)
        make.right.equalTo(contentView.snp.centerX).offset(-5)
        make.centerY.equalToSuperview()
      })
    }
    updateData?()
  }
  
  @objc private func showPicker() {
    switch type {
    case .type, .number:
    let dialogViewController = QMUIDialogSelectionViewController()
    dialogViewController.tableView!.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    dialogViewController.dialogViewMargins = UIEdgeInsets(top: -100, left: 52, bottom: 0, right: 52)
    dialogViewController.headerViewHeight = 0
    dialogViewController.items = type == .type ? ["Radio", "Selección múltiple"] : ["Solo una vez por persona", "Una vez por persona por dia"]
    dialogViewController.heightForItemBlock = { vc, index in
      return 62
    }
    dialogViewController.modalPresentationViewController?.isModal = false
    
    dialogViewController.didSelectItemBlock = { vc, index in
      dialogViewController.hideWith(animated: true, completion: { _ in
        if self.type == .type {
          self.info.type = Int(index) == 0 ? 1 : 0
          self.changeType?()
        } else {
          self.info.times = Int(index + 1)
        }
        self.update(type: self.type, info: self.info)
      })
    }
    dialogViewController.show()
    case .min: break
      
    case .max: break
      
    case .time: break
      
    case .member: break
      
    case .cover:
      let imagePickerViewController = TZImagePickerController(maxImagesCount: 1, columnNumber: 3, delegate: nil)
      imagePickerViewController?.allowPickingVideo = false
      imagePickerViewController?.allowPickingGif = false
      imagePickerViewController?.allowPickingMultipleVideo = false
      imagePickerViewController?.allowPickingOriginalPhoto = true
      imagePickerViewController?.allowCrop = true
      imagePickerViewController?.preferredLanguage = "en"
      let w = screenWidth - 2 * 10
      let h = w / 120 * 68
      imagePickerViewController?.cropRect = CGRect(x: 10, y: (screenHeight - h) / 2, width: w, height: h)      
      imagePickerViewController?.didFinishPickingPhotosHandle = { (photos, assets, isSelect) in
        guard let photos = photos else { return }
        self.info.coverImage = photos.first!
        self.update(type: self.type, info: self.info)
      }
      VCManager.currentViewController.present(imagePickerViewController!, animated: true, completion: nil)
    }
  }
}

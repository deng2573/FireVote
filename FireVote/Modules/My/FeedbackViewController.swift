//
//  FeedbackViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class FeedbackViewController: ViewController {
  
  private lazy var textView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    textView.clipsToBounds = true
    textView.layer.cornerRadius = 5
    textView.font = UIFont.boldSystemFont(ofSize: 14)
    textView.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    textView.isScrollEnabled = false
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    textView.textContainer.lineFragmentPadding = 0
    return textView
  }()
  
  private lazy var saveButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 22
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitle("Enviar", for: .normal)
    button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button.tap(action: { _ in
      HUD.loading()
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        HUD.show(text: "Gracias por tus comentarios.")
        self.navigationController?.popViewController(animated: true)
      }
    })
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = "Comentarios y ayuda"
    view.addSubview(textView)
    textView.snp.makeConstraints({ (make) in
      make.top.equalTo(10)
      make.left.equalTo(16)
      make.right.equalTo(-16)
      make.height.equalTo(250)
    })
    
    view.addSubview(saveButton)
    saveButton.snp.makeConstraints({ (make) in
      make.top.equalTo(textView.snp.bottom).offset(60)
      make.centerX.equalToSuperview()
      make.left.equalTo(20)
      make.right.equalTo(-20)
      make.height.equalTo(44)
    })
  }
}

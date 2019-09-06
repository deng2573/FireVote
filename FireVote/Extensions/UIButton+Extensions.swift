//
//  UIButton+Extensions.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/9.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

extension UIButton {
  func tap(for controlEvents: UIControl.Event = .touchUpInside, action:@escaping (UIButton)->()) {
    let eventObj = AssociatedClosureClass(eventClosure: action)
    eventClosureObj = eventObj
    addTarget(self, action: #selector(eventExcuate(_:)), for: controlEvents)
  }
  
  struct AssociatedClosureClass {
    var eventClosure: (UIButton)->()
  }
  
  private struct AssociatedKeys {
    static var eventClosureObj:AssociatedClosureClass?
  }
  
  private var eventClosureObj: AssociatedClosureClass{
    set{
      objc_setAssociatedObject(self, &AssociatedKeys.eventClosureObj, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
    }
    get{
      return (objc_getAssociatedObject(self, &AssociatedKeys.eventClosureObj) as? AssociatedClosureClass)!
    }
  }

  @objc private func eventExcuate(_ sender: UIButton){
    eventClosureObj.eventClosure(sender)
  }
}

//
//  String+Extensions.swift
//  LeMotion
//
//  Created by Deng on 2019/4/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation
import CommonCrypto
import YYText

extension String {
  func substring(before string: String) -> String? {
    guard let range = self.range(of: string) else { return nil }
    return String(self[..<range.lowerBound])
  }
  
  func substring(after string: String) -> String? {
    guard let range = self.range(of: string) else { return nil }
    return String(self[range.upperBound...])
  }
  
  var md5: String {
    let str = self.cString(using: String.Encoding.utf8)
    let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
    CC_MD5(str!, strLen, result)
    let hash = NSMutableString()
    for i in 0 ..< digestLen {
      hash.appendFormat("%02x", result[i])
    }
    free(result)
    return String(format: hash as String)
  }
  
  func yyText(width: CGFloat = screenWidth, fontSize: CGFloat = 14, textColor: UIColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)) -> (height: CGFloat, text: NSMutableAttributedString) {
    let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    let text = NSMutableAttributedString(string: self)
    text.yy_font = UIFont.systemFont(ofSize: fontSize)
    text.yy_color = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    text.yy_lineSpacing = 4
    text.yy_setKern(0.3, range: text.yy_rangeOfAll())
    let textH = YYTextLayout(containerSize: size, text: text)?.textBoundingSize.height ?? fontSize + 2
    return (textH == 0 ? fontSize + 2 : textH, text)
  }
}



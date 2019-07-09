//
//  NSMutableAttributedString+Extensions.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 06/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import UIKit
extension NSMutableAttributedString {
  @discardableResult func BigTitleString(_ text:String) -> NSMutableAttributedString {
    let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : UIFont.init(name: ".SFUIDisplay-Regular", size: 32) ?? UIFont.boldSystemFont(ofSize: 32)]
    let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
    self.append(boldString)
    return self
  }
  @discardableResult func smallTitleString(_ text:String) -> NSMutableAttributedString {
    var attrs = [NSAttributedString.Key: AnyObject]()
    attrs[NSAttributedString.Key.font] = UIFont.init(name: ".SFUIDisplay-Regular", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
    attrs[NSAttributedString.Key.foregroundColor] = UIColor.black
    let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
    self.append(boldString)
    return self
  }

}

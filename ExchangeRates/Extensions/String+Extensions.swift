//
//  String+Extensions.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 06/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

extension String {
  
  func attributedRate()-> NSAttributedString? {
    let formattedString = NSMutableAttributedString()
    
    if self.count >= 3 {
      return formattedString
        .BigTitleString(String(self.dropLast(2)))
        .smallTitleString(" " + String(self.dropFirst(self.count - 2)))
    }
    return nil
    
  }
  
}

//
//  CurrencyModel.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import UIKit
class CurrencyModel: NSObject {
  
  var code: String!
  var name: String!
  var image: UIImage!

  
  init(currencyCode: String) {
    self.code = currencyCode
    self.name = Locale.current.localizedString(forCurrencyCode:  currencyCode)
    if let anImage = UIImage(named: currencyCode.lowercased()) {
      self.image = anImage
    }
    
    
    
  }
  
}

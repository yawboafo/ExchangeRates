//
//  ExChangeModel.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

class ExChangeModel: NSObject {
  
  
  var firstPairCode: String!
  var secondPairCode: String!
  var exchangeAmountwithCode: String!
  
  var firstPairlocalisedCurrencyCode: String!
  var secondPairlocalisedCurrencyCode: String!
  
  var rate: Double!
  var exchangedRate: Double!
  var pairedValue: String!
  var convertedRate: String!
  var attributedRate: NSAttributedString!
  
  override init() {
    super.init()
  }
  init(key: String , value: Double) {
    self.pairedValue =  key
    self.firstPairCode =  String(key.dropLast(3))
    self.secondPairCode = String(key.dropFirst(3))
    self.exchangeAmountwithCode = "1 \(self.firstPairCode ?? "")"
    self.firstPairlocalisedCurrencyCode = Locale.current.localizedString(forCurrencyCode:  String(key.dropLast(3)))
    self.secondPairlocalisedCurrencyCode = "\(Locale.current.localizedString(forCurrencyCode:  self.secondPairCode) ?? "") . \(self.secondPairCode ?? "")"
    self.rate =  value
    self.exchangedRate =  value * 1.0
    self.convertedRate = Converter.formatDoubleToMoney(self.exchangedRate)
    self.attributedRate = convertedRate.attributedRate()
 
  }
  
}


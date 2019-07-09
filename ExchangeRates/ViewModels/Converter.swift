//
//  Converter.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 07/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import UIKit
class Converter {
  
  
  static func convertCurrency(rate: Double, amount: Double) -> Double {
    var defaultAmount = 0.0
    defaultAmount = ((amount <= 0) ?  rate :  rate * amount)
    return defaultAmount
    
  }
  
  
  static func formatDoubleToMoney(_ n : Double)-> String{
    
    
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    let s2 = formatter.string(from: NSNumber(value: n)) ?? ""
    
    return  s2
    
  }
  
  
  
  
  static func getImageByCurrencyCode(code: String)-> UIImage {
    
    
    return UIImage(named: code.lowercased()) ?? UIImage(named: "eur")!
    
  }
}


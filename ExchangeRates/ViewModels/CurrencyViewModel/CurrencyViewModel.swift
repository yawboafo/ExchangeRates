//
//  CurrencyViewModel.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

class CurrencyViewModel: NSObject {
  
  
  
  
  func getCurrencyJsonFilePath() -> String? {
    return Bundle.main.path(forResource: Constant.CurrencyJSonFilePath, ofType:  Constant.BundleTypeJson)
  }
  func currencyJsonFileExistInBundle() -> Bool {
    
    if getCurrencyJsonFilePath() != nil {
      return true
    }
    return false
  }
  
  func currencyList()  -> [String] {
    
    var currencies : [String] = []
    if currencyJsonFileExistInBundle() == true {
      do {
        
        let data = try Data(contentsOf: URL(fileURLWithPath: getCurrencyJsonFilePath()!), options: .alwaysMapped)
        currencies = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String]
        
      }catch{
        currencies = []
      }
    }
    
    
    return currencies
    
  }
  func currencyModelList() -> [CurrencyModel]{
    
    return  currencyList().compactMap({ string in
            CurrencyModel(currencyCode: string)
            }).sorted(by: {$0.code < $1.code} )
    

    
  }
  
  
  
}


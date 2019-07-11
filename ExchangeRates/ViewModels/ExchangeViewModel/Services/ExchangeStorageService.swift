//
//  ExchangeStorage.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 08/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import CoreData
protocol ExchangeStorageDelegate {
  func insertPair(value: String)
  func savePairs(sets: Set<String>)
  func getPairs() -> Set<String>
  func removePair(value: String)
  func getExchangeRatesParameters() -> [(String,String)]

}


final class ExchangeStorageService : ExchangeStorageDelegate {
  
  let defaults = UserDefaults.standard
  
  func insertPair(value: String){
    let defaults = UserDefaults.standard
    var previousSets =  getPairs()
    previousSets.insert(value)
    defaults.set(Array(previousSets), forKey: "pairedSets")
  }
  
  func savePairs(sets: Set<String>){
    
    let defaults = UserDefaults.standard
    defaults.set(Array(sets), forKey: "pairedSets")
    
  }
  
  func getPairs() -> Set<String> {
    let defaults = UserDefaults.standard
    guard let array = defaults.array(forKey: "pairedSets")  else { return [] }
    
    var sets : Set<String> = []
    
    array.forEach { string in
      sets.insert(string as! String)
    }
    return sets
    }
  
  func removePair(value: String) {
    print("before remove : " , getPairs())
    var pairs = getPairs()
    pairs.remove(value)
    print("after remove : " , pairs)
    savePairs(sets: pairs)
  }
  
  func getExchangeRatesParameters() -> [(String,String)]  {
      var parameter = [(String,String)]()
      let requestKey : String = "pairs"
      parameter =  getPairs().compactMap({ key in
        (requestKey,key)
      })
      
      return parameter
 
  
}
  
  

}

//
//  ExchangeViewModel.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation


enum NotifyView {
  case error
}

enum DidSetMode{
  case delete
  case update
}

class ExChangeViewModel: NSObject {
  
  var errorNotify :((String) -> ()) = { data in  }
  var update :(() -> ()) = {  }
  
  var pairsHandler = DidSetMode.update
  let repo = ExchangeRepo()
  let nertWorkService = ExchangeAPIService()
  let storage = ExchangeStorageService()
 
  var timer : Timer!
  var pair: String = ""
  
  var xchangeRates = [ExChangeModel]() {
      didSet {
        self.update()
    }
   }
  
  var pairs = Set<String>() {
      didSet {
        
        switch pairsHandler {
        case .delete:
          //Do nothing
          break
        case .update:
           self.loadRates()
        }
       
        
        
    }
  }
  var error = RequestError.noData{
    didSet { self.errorNotify(RequestError.errorName(error: error)) }
  }
  
  func loadRates(){
    repo.getRates {[weak self] result  in
    guard let self = self else { return }
    switch result {
    case .success(let rates): self.xchangeRates = rates
    case .failure( let _error ): self.xchangeRates = [] ; self.timer.invalidate() ; self.error = _error
     }
       }
    }
  func infinityRateFetcher(){
     timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
       self.loadRates()
       })
     timer.fire()
  
   }
  
  func shouldDisable(_pair: String) -> Bool {
    
    var itExist: Bool = false
        if _pair == self.pair {
        return true
    }
      repo.pairs().forEach { item in
      if (self.pair + _pair)  == item {
        itExist =  true
        return
      }
    }
    
    return itExist
  }
  
  
  
}




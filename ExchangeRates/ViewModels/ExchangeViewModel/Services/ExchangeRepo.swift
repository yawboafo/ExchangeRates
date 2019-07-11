//
//  ExchangeRepo.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 07/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
protocol ExchangeRepoDelegate {
 
  func insert(pair: String)
  func remove(pair: String)
  func pairs()-> Set<String>
  func rates()->[ExChangeModel]
  func getRates(completion: @escaping (Result<[ExChangeModel], RequestError>) -> Void)
 
}

final class ExchangeRepo : ExchangeRepoDelegate {
  
 
  private let apiService: ExchangeAPIService
  private let sService: ExchangeStorageService
  private var _rates : [ExChangeModel] = []
  
  
  init(nertWorkservice: ExchangeAPIService = ExchangeAPIService(),
    storageService: ExchangeStorageService = ExchangeStorageService()) {
    self.apiService = nertWorkservice
    self.sService = storageService
  }
  func getRates(completion: @escaping (Result<[ExChangeModel], RequestError>) -> Void) {
  apiService.getExchangeRates(parameters: sService.getExchangeRatesParameters()) { results in
    
    switch results {
      case .success(let resultValue):
        
        
      self._rates =  resultValue.compactMap({ key,value in
        ExChangeModel(key: key, value: value)
      }).sorted(by: {$0.secondPairlocalisedCurrencyCode < $1.secondPairlocalisedCurrencyCode })
      completion(.success(self._rates))
      
     
      
      break
      case .failure(let error):
      completion(.failure(error))
      break
    }
  }
}
  
  
  func rates() -> [ExChangeModel] {
    return self._rates
  }
  
  func pairs() -> Set<String> {
    return sService.getPairs()
  }
  
  func remove(pair: String) {
    sService.removePair(value: pair)
  }
   
  func insert(pair: String) {
    sService.insertPair(value: pair)
  }
  
  
  
  
  
  
  
}



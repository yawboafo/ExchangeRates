//
//  ExchangeAPIService.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 07/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
protocol ExchangeAPIServiceDelegate {
  func getExchangeRates(parameters: RequestParameters, completion: @escaping (Result<ExchangeResponse, RequestError>) -> Void)
}

final class ExchangeAPIService: ExchangeAPIServiceDelegate {
  
  func getExchangeRates(parameters: RequestParameters, completion: @escaping (Result<ExchangeResponse, RequestError>) -> Void) {
    
    guard let apiRequest = try? APIURLRequest(urlString: RequestURLs.exchangeURL, method: .get, params: parameters, headers: [:]) else { return  }
    let request = RequestExecuter(a: apiRequest)
    request.fireRequest(completionQueue: .global()) { response in
      main {
        completion(response)
      }
    }
  }

}


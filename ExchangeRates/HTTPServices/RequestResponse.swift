//
//  RequestResponse.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 06/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

enum RequestResponse<Value> {
  case success(HTTPURLResponse, Value)
  case failure(HTTPURLResponse?, RequestError)
  
  var result: Result<Value, RequestError> {
    switch self {
    case .success(_, let value):
      return .success(value)
    case .failure(_, let error):
      return .failure(error)
    }
  }
}

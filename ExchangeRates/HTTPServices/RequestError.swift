//
//  RequestError.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 06/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

enum RequestError: Error {
  case unknown
  case badUrl
  case noResponse
  case noData
  case failedToDecode(Error)
  case noInternet
  case badBody
  case authRequired
  case hostUnknown
  case badResponse
  
  
  
  
static  func errorName(error: RequestError)->String {
    
    var errorString = ""
    switch error {
    case .unknown:
      errorString = "Unknown Error response"
    case .badUrl:
      errorString = "Bad Url"
    case .noResponse:
       errorString = "No response from server"
    case .noData:
      errorString = "No data from response"
    case .failedToDecode(_):
       errorString = "Failed to decode data from server"
    case .noInternet:
       errorString = "No internet connection"
    case .badBody:
       errorString = "Bad Request body"
    case .authRequired:
      errorString = "Authentication required"
    case .hostUnknown:
       errorString = "Unknown Host"
    case .badResponse:
      errorString = "Bad response"
    
    }
    
    return errorString
  }
}








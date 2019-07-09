//
//  APIRequest.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 07/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

public typealias RequestParameters = [(String,String)]
public typealias RequestHeaders = [String:String]

class APIURLRequest {
  
  var defaultTimeOut: TimeInterval!
  var request : URLRequest!
  var httpMethod: HTTPMethod!
  var parameter:RequestParameters!
  var url: URLComponents!
  private var headers: [String:String] = {
    var defaultHeaders = [String:String]()
    defaultHeaders["Content-Type"] = "application/json"
    return defaultHeaders
  }()
  
  
  init(urlString: String,
       method: HTTPMethod,
       params:RequestParameters,
       headers:RequestHeaders,timeoutInterval: TimeInterval = 30) throws {
    
   
    guard let url = URLComponents(string: urlString) else { throw RequestError.badUrl }
    self.url = url
    self.httpMethod = method
    self.headers.update(other: headers)
    switch method {
    case .get:
    self.url.queryItems =  params.map { element in URLQueryItem(name: element.0, value: element.1) }
    guard let finalUrl = URL(string: self.url.url!.absoluteString) else {throw RequestError.badUrl }
    self.request = URLRequest(url:finalUrl , timeoutInterval: timeoutInterval)
    break
    default: break
      
    }
    

    
    
  }
  
}

//
//  RequestExecuter.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 07/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

final class RequestExecuter {
  let urlSession = URLSession.shared
  var request : APIURLRequest!
  
  
  init(a request : APIURLRequest) {
    self.request = request
  }
 
  
  func fireRequest<T>(completionQueue: DispatchQueue = .main,completionHandler: @escaping (Result<T,RequestError>) -> Void) where T : Decodable{
    
   
    urlSession.dataTask(with: request.request) { (data, response, error) in
       guard error == nil else {return completionHandler(.failure(RequestError.unknown))}
       guard let data = data else {return completionHandler(.failure(RequestError.noData))}
       guard let httpResponse = response as? HTTPURLResponse else { return completionHandler(.failure(RequestError.noResponse)) }
     
      
      switch httpResponse.statusCode {
      case 200...299:
        do {
          let value = try JSONDecoder().decode(T.self, from: data)
          return completionHandler(.success(value))
        }
        catch let error {
          return completionHandler(.failure(RequestError.failedToDecode(error)))
        }
        
      case 403:
       
        return completionHandler(.failure(RequestError.authRequired))
      case 404:
         return completionHandler(.failure(RequestError.hostUnknown))
      case 500:
    
          return completionHandler(.failure(RequestError.badResponse))
      case -1009:
         return completionHandler(.failure(RequestError.noInternet))
      default: break
      }
    

      }.resume()
    
  }

  
}

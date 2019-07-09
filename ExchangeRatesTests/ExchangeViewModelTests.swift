//
//  ExchangeModelTests.swift
//  ExchangeRatesTests
//
//  Created by Engineer 144 on 08/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest

@testable import ExchangeRates
class ExchangeViewModelTests: XCTestCase {
  
  
  
   let repo = ExchangeRepo()
    override func setUp() {
    }

    override func tearDown() {
    }

  
  func testRatesAPIResponse (){
    
    
    let expect = expectation(description: "Should download rates")
    repo.getRates { result  in
  
      switch result {
      case .success(let rates): XCTAssertNotNil(rates)
      case .failure( let error ): XCTAssertNil(error)
      }
      expect.fulfill()
      
    }
    
    waitForExpectations(timeout: 5) { error in
      XCTAssertNil(error, "Timed Out. \(error?.localizedDescription ?? "Time out error")")
    }
    
    XCTAssertTrue(repo.rates().count > 0 , "Repo count must be more than Zero")
    
    
  }
  
  func testRatesInAPIResponse(){
    
   
  }
  
  
  
}

//
//  ExchangeModelTests.swift
//  ExchangeRatesTests
//
//  Created by Engineer 144 on 08/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest
@testable import ExchangeRates
class ExchangeModelTests: XCTestCase {
  
  var model : ExChangeModel!
  var currency : String!
  var currencyViewModel : CurrencyViewModel!
  
    override func setUp() {
      
      currencyViewModel = CurrencyViewModel()
      currency = currencyViewModel.currencyList().first
      currency.append(currencyViewModel.currencyList().last ?? "USD")
      model = ExChangeModel(key:currency,value: 1.0)
  
  }

    override func tearDown() {
      
    }


  func testModelSetUp(){
    
    XCTAssertTrue(model.pairedValue.count == 6,"Valid Code")
    XCTAssertTrue(model.secondPairCode.count == 3,"Valid Code")
    XCTAssertTrue(model.firstPairCode.count == 3,"Valid Code")
    XCTAssertNotNil(model.attributedRate)
    XCTAssertNotNil(model.firstPairCode)
    XCTAssertNotNil(model.secondPairCode)
    XCTAssertNotNil(model.firstPairlocalisedCurrencyCode)
    XCTAssertNotNil(model.secondPairlocalisedCurrencyCode)
    
  }

}

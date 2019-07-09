//
//  CurrencyModelTest.swift
//  ExchangeRatesTests
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest


@testable import ExchangeRates
class CurrencyModelTest: XCTestCase {
  
  
  var model : CurrencyModel!
  var viewModel : CurrencyViewModel!
  var currencies : [String]!

    override func setUp() {
        model = CurrencyModel(currencyCode: "SGD")
      
        viewModel = CurrencyViewModel()
        currencies = viewModel.currencyList()
     }

    override func tearDown() {
        model = nil
     }

  func testCurrencyModel(){
    
    
   
    //for item in currencies {
   
      //let model = CurrencyModel(currencyCode: item)
      
      XCTAssertTrue(model.code.count == 3,"Valid Code")
      XCTAssertNotNil(model.code)
      XCTAssertNotNil(model.name)
      XCTAssertNotNil(model.image)
      XCTAssertNotEqual(model.code, model.name, "Code should not be the same as localisedName")
   
    }

}

//
//  CurrencyViewModelTest.swift
//  ExchangeRatesTests
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest

@testable import ExchangeRates

class CurrencyViewModelTest: XCTestCase {
  
  var viewModel : CurrencyViewModel!
  var currencies : [String]!
  var currencyModels: [CurrencyModel]!
  

    override func setUp() {
      
      viewModel = CurrencyViewModel()
      currencies = viewModel.currencyList()
      currencyModels = viewModel.currencyModelList()
    }

    override func tearDown() {
      
        currencyModels = []
        currencies = []
        viewModel = nil
    }
  
  func testJsonFileExist(){
    
    
    XCTAssertNotNil(viewModel.getCurrencyJsonFilePath(), "This should not be NIL")
    XCTAssertTrue(viewModel.currencyJsonFileExistInBundle(), "This should be True")
  }

  func testCurrencyJsonFromFile(){
    
    XCTAssertTrue(viewModel.currencyList().count > 0, "Should not be less than Zero")
   
  }

  func testCurrencyModelListTransformation(){
    
     XCTAssertTrue(currencyModels.count > 0, "Should not be less than Zero")
     XCTAssertEqual(currencyModels.count, currencies.count , "Currency count must be equal to currencyModelList count ")
  }
  
  
}

//
//  GCD+Extensions.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//



import Foundation

func background(work: @escaping () -> ()) {
  DispatchQueue.global(qos: .userInitiated).async {
    work()
  }
}

func main(work: @escaping () -> ()) {
  DispatchQueue.main.async {
    work()
  }
}


func delay(time: Double,work: @escaping () -> ()){
  
  DispatchQueue.main.asyncAfter(deadline: .now() + time) {
   
    work()
  }
}

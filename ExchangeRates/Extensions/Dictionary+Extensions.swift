//
//  Dictionary+Extension.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 06/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

public extension Dictionary {
  mutating func update(other:Dictionary) {
    for (key,value) in other {
      self.updateValue(value, forKey:key)
    }
  }
}

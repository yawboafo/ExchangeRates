//
//  DBExchange+CoreDataProperties.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 08/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//
//

import Foundation
import CoreData


extension DBExchange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBExchange> {
        return NSFetchRequest<DBExchange>(entityName: "PairedRate")
    }

    @NSManaged public var pair: String
    @NSManaged public var rate: Double
  
  
  
  func upDate(model: ExChangeModel){
    self.rate = model.rate
    self.pair = model.pairedValue
  }
  
  func toModel()-> ExChangeModel{
    return ExChangeModel(key: pair, value: rate)
  }
  


}

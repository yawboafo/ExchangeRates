//
//  ExchangeStorage.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 08/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import CoreData
protocol ExchangeStorageDelegate {
  func insertPair(value: String)
  func savePairs(sets: Set<String>)
  func getPairs() -> Set<String>
  func removePair(value: String)
  func getExchangeRatesParameters() -> [(String,String)]
  
  func saveXchangeRates(key: String,value: Double)
  func getPairedRate(by key: String)-> DBExchange
  func udpatePairedRate(by key: String,with value: Double, on model : DBExchange)
  func deletePairedRate(by key: String) ->[DBExchange]
  func deletePairedRate(by model: DBExchange)
  func getXchangeRates() -> [DBExchange]
}


final class ExchangeStorageService : ExchangeStorageDelegate {
  
  
  
  
  
  let coreDataManager = CoreDataManager.sharedManager
  let defaults = UserDefaults.standard
  let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
  
  func getXchangeRates() -> [DBExchange] {
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
   
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PairedRate")
    
   
    do {
      let pairedRates = try managedContext.fetch(fetchRequest)
      return (pairedRates as? [DBExchange] ?? [])
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return []
    }
  }
  
  
  

  func deletePairedRate(by model : DBExchange){
    
    
    do {
       managedContext.delete(model)
      
       } catch  {
       print(error)
    }
    
    do {
      try managedContext.save()
    } catch {
     
    }
  }
  func deletePairedRate(by key: String) -> [DBExchange]  {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PairedRate")
    fetchRequest.predicate = NSPredicate(format: "pair == %@" ,key)
    do {
      
     
      let item = try managedContext.fetch(fetchRequest)
      var arrRemovedPairs = [DBExchange]()
      for i in item {
       
        managedContext.delete(i)
        try managedContext.save()
        arrRemovedPairs.append(i as! DBExchange)
      }
      return arrRemovedPairs
      
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return []
    }
  }
  func udpatePairedRate(by key: String, with value: Double, on model: DBExchange) {

    model.pair = key
    model.rate = value
    do {
      try managedContext.save()
      } catch let error as NSError  {
      print("Could not save \(error), \(error.userInfo)")
    } catch {
      
    }
  
}
  
  
  func getPairedRate(by key: String) -> DBExchange {
   

    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PairedRate")
    request.predicate = NSPredicate(format: "pair == %@", key)
    request.fetchLimit = 1
    request.returnsObjectsAsFaults = false
    var entity = DBExchange(context: managedContext)
    
    do {
      let items = try managedContext.fetch(request)
      if ((items as? [DBExchange]) ?? []).count > 0 {
        entity = ((items as? [DBExchange]) ?? [ ]).first!
      }
      
    } catch let error as NSError {
      print(error.userInfo)
    }
    
    return entity
    
  }
  
  func saveXchangeRates(key: String, value: Double) {
    let entity = self.getPairedRate(by: key)
    entity.pair = key
    entity.rate = value
    
   do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
     }
  
    
  }
 

  func insertPair(value: String){
    let defaults = UserDefaults.standard
    var previousSets =  getPairs()
    previousSets.insert(value)
    defaults.set(Array(previousSets), forKey: "pairedSets")
  }
  
  func savePairs(sets: Set<String>){
    
    let defaults = UserDefaults.standard
    defaults.set(Array(sets), forKey: "pairedSets")
    
  }
  
  func getPairs() -> Set<String> {
    let defaults = UserDefaults.standard
    guard let array = defaults.array(forKey: "pairedSets")  else { return [] }
    
    var sets : Set<String> = []
    
    array.forEach { string in
      sets.insert(string as! String)
    }
    
    return sets
    
  }
  
  func removePair(value: String) {
    print("before remove : " , getPairs())
    var pairs = getPairs()
    pairs.remove(value)
    print("after remove : " , pairs)
    savePairs(sets: pairs)
  }
  
  

  
  func getExchangeRatesParameters() -> [(String,String)]  {
      var parameter = [(String,String)]()
      let requestKey : String = "pairs"
      parameter =  getPairs().compactMap({ key in
        (requestKey,key)
      })
      
      return parameter
 
  
}
  
  

}

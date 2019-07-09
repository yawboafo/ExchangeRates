//
//  CoreDataManager.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 08/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import CoreData
class CoreDataManager {
  

  static let sharedManager = CoreDataManager()
  private init() {} // Prevent clients from creating another instance.
  

  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Rates_DB")
     container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.newBackgroundContext()
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  
  
}


//
//  CoreDataStack.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 08/04/22.
//

import Foundation
import CoreData

class CoreDataManager {
  
  // MARK: - Properties

  static let manager = CoreDataManager()
  
  // MARK: - Basic Function
  lazy var managedContext: NSManagedObjectContext = {
    return self.persistentContainer.viewContext
  }()
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "OdyModel")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  func saveContext () {
    guard managedContext.hasChanges else { return }

    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
  
  // MARK: - Goals Functions
  func insertGoals(goalsName: String, goalsCount: Int16) {
    let context = CoreDataManager.manager.managedContext
    let goals = Goals(context: context)
    
    goals.goalsName = goalsName
    goals.goalsCount = goalsCount
    
    try? context.save()
  }
  
  func deleteGoals(goals: Goals) {
    let context = CoreDataManager.manager.managedContext
    context.delete(goals)
  }
  
  
  func updateDayCount(to goalsCount: Int16, for goals: Goals) {
    let context = CoreDataManager.manager.managedContext
    goals.goalsCount = goalsCount+1
    try? context.save()
  }
  
  func fetchGoals() -> Goals? {
    let request = NSFetchRequest<Goals>(entityName: "Goals")
    let goals = try! CoreDataManager.manager.managedContext.fetch(request)
    return goals[0]
  }
  
  // MARK: - Notifications Functions
  func insertStartDate() {
    
  }
  
  func insertEndDate() {
    
  }
  
  func insertPreferences() {
    
  }
  
  func insertCustomDays() {
    
  }
  
  // MARK: - Timer Functions
  func insertTimer() {
    
  }
  
  
}

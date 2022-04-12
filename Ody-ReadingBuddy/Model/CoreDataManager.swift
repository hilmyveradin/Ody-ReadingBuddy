//
//  CoreDataStack.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 08/04/22.
//

import Foundation
import CoreData

public class CoreDataManager {
  
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
  
  // MARK: - My Goals Functions
  
  // for interface juga, jadi butuh semuanya
  func insertGoal(goalsName: String?, startDate: Date?, endDate: Date?, duration: Date? ) {
    let context = CoreDataManager.manager.managedContext
    let goals = MyGoals(context: context)
    
    if let goalsName = goalsName,
       let startDate = startDate,
       let endDate = endDate,
       let duration = duration {
      
      goals.goalsName = goalsName
      goals.endDate = endDate
      goals.startDate = startDate
      goals.duration = duration
      
      try? context.save()
    }
  }
  
  func deleteGoals() {
    let context = CoreDataManager.manager.managedContext
    let request = NSFetchRequest<MyGoals>(entityName: "MyGoals")
    let goals = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if goals.count > 0 {
      context.delete(goals[0])
      try? context.save()
    }
  }
  
  // ini buat set interface juga
  func fetchGoals() -> MyGoals? {
    let request = NSFetchRequest<MyGoals>(entityName: "MyGoals")
    let goals = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if goals.count > 0 {
      print("nubmer of goals: \(goals.count)")
      return goals[0]

    } else {
      return nil
    }
    
  }
  
  // MARK: - Preferences Functions
  
  // buat ngobrol sama view controller lain, etc.
  func insertPreferences(index: Int16?, hours: [Int]?) {
    let context = CoreDataManager.manager.managedContext
    let preference = Preferences(context: context)
    
    if let index = index,
       let hours = hours {
      preference.preferencesIndex = index
      preference.hours = hours
      try? context.save()
    }
  }
  
  func deletePreferences() {
    let context = CoreDataManager.manager.managedContext
    let request = NSFetchRequest<Preferences>(entityName: "Preferences")
    let preferences = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if preferences.count > 0 {
      context.delete(preferences[0])
      try? context.save()
    }
  }
  
  func fetchPreferences() -> Preferences? {
    let request = NSFetchRequest<Preferences>(entityName: "Preferences")
    let preferences = try! CoreDataManager.manager.managedContext.fetch(request)
    if preferences.count > 0 {
      return preferences[0]
    } else {
      return nil
    }
  }
  
  // MARK: - Home Functions
  func insertHomeTarget(daysTarget: Int16?, timeTarget: Int64?) {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    
    if let daysTarget = daysTarget,
       let timeTarget = timeTarget {
      home.daysTarget = daysTarget
      home.timeTarget = timeTarget
      home.daysTarget = 0
      home.timeTarget = 0
      try? context.save()
    }
  }
  
  func increaseDaysSpent() {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    home.daysSpent += 1
    try? context.save()
  }
  
  func increaseTimeSpent(addedTimeSpent: Int64) {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    home.timeSpent += addedTimeSpent
    try? context.save()
  }
  
  func resetTimeSpent() {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    home.daysSpent = 0
    try? context.save()
  }
  
  func deleteHome() {
    let context = CoreDataManager.manager.managedContext
    let request = NSFetchRequest<Home>(entityName: "Home")
    let home = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if home.count > 0 {
      context.delete(home[0])
      try? context.save()
    }
  }
  
  func fetchHome() -> Home? {
    let request = NSFetchRequest<Home>(entityName: "Home")
    let home = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if home.count > 0 {
      return home[0]
    } else {
      return nil
    }
    
  }
  
  // MARK: - Timer Functions
  
  func insertTimer(currentTimer: Int16?) {
    let context = CoreDataManager.manager.managedContext
    let timer = TimerInterface(context: context)
    
    if let currentTimer = currentTimer {
      timer.currentTimer = currentTimer
      try? context.save()
    }
  }
  
  func deleteTimer() {
    let context = CoreDataManager.manager.managedContext
    let request = NSFetchRequest<TimerInterface>(entityName: "TimerInterface")
    let timer = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if timer.count > 0 {
      context.delete(timer[0])
      try? context.save()
    }
  }
  
  func fetchTimer() -> TimerInterface? {
    let request = NSFetchRequest<TimerInterface>(entityName: "TimerInterface")
    let timer = try! CoreDataManager.manager.managedContext.fetch(request)
    if timer.count > 0 {
      return timer[0]
    } else {
      return nil
    }
    
  }
  
  func updateTimer(currentTimer: Int16 ) {
    let context = CoreDataManager.manager.managedContext
    let timer = TimerInterface(context: context)
    timer.currentTimer += currentTimer
    try? context.save()
  }
  
  //reset dialy
  func resetTimerDialy() {
    let context = CoreDataManager.manager.managedContext
    let timer = TimerInterface(context: context)
    timer.currentTimer = 0
    try? context.save()
  }
  
  // MARK: - isGoalsSelected
  
  func insertIsGoalsSelected(isGoalsExists: Bool?) {
    let context = CoreDataManager.manager.managedContext
    let isGoalsSelected = IsGoalsSelected(context: context)
    
    if let isGoalsExists = isGoalsExists {
      isGoalsSelected.isGoalsSelected = isGoalsExists
      try? context.save()
    }
    
  }
  
  func deleteIsGoalsSelected() {
    let context = CoreDataManager.manager.managedContext
    let request = NSFetchRequest<IsGoalsSelected>(entityName: "IsGoalsSelected")
    let isGoalsSelected = try! CoreDataManager.manager.managedContext.fetch(request)
    
    if isGoalsSelected.count > 0 {
      context.delete(isGoalsSelected[0])
      try? context.save()
    }
  }
  
  // ini buat set interface juga
  func fetchIsGoalsSelected() -> IsGoalsSelected? {
    let request = NSFetchRequest<IsGoalsSelected>(entityName: "IsGoalsSelected")
    let isGoalsSelected = try! CoreDataManager.manager.managedContext.fetch(request)
    if isGoalsSelected.count > 0 {
      print("nubmer of isgoalsselected: \(isGoalsSelected.count)")
      return isGoalsSelected[0]
    } else {
      return nil
    }
    
  }
  
//  // MARK: - Weekdays Function
//  func insertHours(weekArray: [Int]?) {
//    let context = CoreDataManager.manager.managedContext
//    let weekdays = Weekdays(context: context)
//
//    if let weekArray = weekArray {
//      weekdays.weekdays = weekArray
//    }
//  }
//
//  func deleteTimer(weekdays: Weekdays) {
//    let context = CoreDataManager.manager.managedContext
//    context.delete(weekdays)
//  }
//
//  func fetchTimer() -> Weekdays? {
//    let request = NSFetchRequest<Weekdays>(entityName: "Weekdays")
//    let weekdays = try! CoreDataManager.manager.managedContext.fetch(request)
//    return weekdays[0]
//  }
//}
}

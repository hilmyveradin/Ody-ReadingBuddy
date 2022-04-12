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
  func insertGoal(goalsName: String?, startDate: Date?, endDate: Date?, isCustom: Bool?, duration: Date? ) {
    let context = CoreDataManager.manager.managedContext
    let goals = MyGoals(context: context)
    
    if let goalsName = goalsName,
       let startDate = startDate,
       let endDate = endDate,
       let isCustom = isCustom,
       let duration = duration {
      
      goals.goalsName = goalsName
      goals.endDate = endDate
      goals.startDate = startDate
      goals.duration = duration
      goals.isCustom = isCustom
      
      try? context.save()
    }
  }
  
  func deleteGoals(goals: MyGoals) {
    let context = CoreDataManager.manager.managedContext
    context.delete(goals)
  }
  
  // ini buat set interface juga
  func fetchGoals() -> MyGoals? {
    let request = NSFetchRequest<MyGoals>(entityName: "MyGoals")
    let goals = try! CoreDataManager.manager.managedContext.fetch(request)
    return goals[0]
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
  
  func deletePreferences(preferences: Preferences) {
    let context = CoreDataManager.manager.managedContext
    context.delete(preferences)
  }
  
  func fetchPreferences() -> Preferences {
    let request = NSFetchRequest<Preferences>(entityName: "Preferences")
    let preferences = try! CoreDataManager.manager.managedContext.fetch(request)
    return preferences[0]
  }
  
  // MARK: - Home Functions
  func insertHomeTarget(daysTarget: Int16?, timeTarget: Int16?) {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    
    if let daysTarget = daysTarget,
       let timeTarget = timeTarget {
      home.daysTarget = daysTarget
      home.timeTarget = timeTarget
      home.daysTarget = 0
      home.timeTarget = 0
    }
  }
  
  func increaseDaysSpent() {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    home.daysSpent += 1
  }
  
  func increaseTimeSpent(addedTimeSpent: Int16) {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    home.timeSpent += addedTimeSpent
  }
  
  func resetTimeSpent() {
    let context = CoreDataManager.manager.managedContext
    let home = Home(context: context)
    home.daysSpent = 0
  }
  
  func deleteHome(home: Home) {
    let context = CoreDataManager.manager.managedContext
    context.delete(home)
  }
  
  func fetchHome() -> Home? {
    let request = NSFetchRequest<Home>(entityName: "Home")
    let home = try! CoreDataManager.manager.managedContext.fetch(request)
    return home[0]
  }
  
  // MARK: - Timer Functions
  
  func insertTimer(currentTimer: Int16?) {
    let context = CoreDataManager.manager.managedContext
    let timer = TimerInterface(context: context)
    
    if let currentTimer = currentTimer {
      timer.currentTimer = currentTimer
    }
  }
  
  func deleteTimer(timer: TimerInterface) {
    let context = CoreDataManager.manager.managedContext
    context.delete(timer)
  }
  
  func fetchTimer() -> TimerInterface? {
    let request = NSFetchRequest<TimerInterface>(entityName: "TimerInterface")
    let timer = try! CoreDataManager.manager.managedContext.fetch(request)
    return timer[0]
  }
  
  func updateTimer(currentTimer: Int16 ) {
    let context = CoreDataManager.manager.managedContext
    let timer = TimerInterface(context: context)
    timer.currentTimer += currentTimer
  }
  
  //reset dialy
  func resetTimerDialy() {
    let context = CoreDataManager.manager.managedContext
    let timer = TimerInterface(context: context)
    timer.currentTimer = 0
  }
  
  // MARK: - Weekdays Function
  func insertHours(weekArray: [Int]?) {
    let context = CoreDataManager.manager.managedContext
    let weekdays = Weekdays(context: context)
    
    if let weekArray = weekArray {
      weekdays.weekdays = weekArray
    }
  }
  
  func deleteTimer(weekdays: Weekdays) {
    let context = CoreDataManager.manager.managedContext
    context.delete(weekdays)
  }
  
  func fetchTimer() -> Weekdays? {
    let request = NSFetchRequest<Weekdays>(entityName: "Weekdays")
    let weekdays = try! CoreDataManager.manager.managedContext.fetch(request)
    return weekdays[0]
  }
}

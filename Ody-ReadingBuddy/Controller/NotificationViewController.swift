//
//  NotificationViewController.swift
//  ReadingApp-Dummy
//
//  Created by Hilmy Veradin on 06/04/22.
//

import Foundation
import UIKit
import CloudKit

class NotificationViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet weak var prefView: UITableView!
  @IBOutlet weak var reminderButton: UIButton!
  
  var preferences : Preferences?
  var myGoals : MyGoals?
  var isGoalsSelected : IsGoalsSelected?
  var isGoalsExists = false
  
  var periodArray : [timePeriod] = [
    timePeriod(periodName: "Morning", periodStart: "05.00", periodFinish: "11.59", periodState: false),
    timePeriod(periodName: "Afternoon", periodStart: "12.00", periodFinish: "15.59", periodState: false),
    timePeriod(periodName: "Evening", periodStart: "16.00", periodFinish: "19.59", periodState: false),
    timePeriod(periodName: "Night", periodStart: "20.00", periodFinish: "22.59", periodState: false),
    //    timePeriod(periodName: "Midnight", periodStart: "23.00", periodFinish: "04.59", periodState: false)
  ]
  
  var selectedHours : [Int]!
  var savedIndex = 0
  var selectedItemDict = [
    0 : [5, 12],
    1 : [12, 16],
    2 : [16, 20],
    3 : [20, 24],
  ]
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchInLoad()
    setupView()
  }
  
  // MARK: - View Actions
  
  @IBAction func saveReminderAction(_ sender: Any) {
    
    if isGoalsExists == true {
      let alert = UIAlertController(title: "Reminder Saved", message: "You have sucessfully saved reminder" , preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] _ in
        resetNotification()
      }))
      self.present(alert, animated: true, completion: nil)
      print("save reminder")
    } else {
      let alert = UIAlertController(title: "Save Failed!", message: "You have to save your goals first" , preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default))
      self.present(alert, animated: true, completion: nil)
    }
    
    
  }
  
  // MARK: - Action Helpers
  
  private func resetNotification() {
    /*
     1. save index preference and hours preferences
     2. reset notifications
     3. fetch data dari my Goals
     4. re-upload notifications
     */
    
    // 1
    CoreDataManager.manager.insertPreferences(index: Int16(savedIndex), hours: selectedHours)
    // 2
    NotificationManager.manager.resetNotification()
    
    if selectedHours != nil {
      // 3
      guard let myGoals = CoreDataManager.manager.fetchGoals() else {
        return print("fetch failed")
      }
      // 4
      NotificationManager.manager.monthDateFormatter(startDate: myGoals.startDate!, endDate: myGoals.endDate!)
      NotificationManager.manager.dayDateFormatter(startDate: myGoals.startDate!, endDate: myGoals.endDate!)
      NotificationManager.manager.getHours(hours: selectedHours)
      NotificationManager.manager.getNotification()
    }
  }
  
  
}

// MARK: - Setup Views
extension NotificationViewController {
  
  func fetchInLoad() {
    /*
     1. fetch myPreferences (for a placeholder)
     2. fetch isGoalsSelected (for making "blocker" appears/not)
     */
    // 1
    let myPreferences = CoreDataManager.manager.fetchPreferences()
    if let myPreferences = myPreferences {
      selectedHours = myPreferences.hours
      savedIndex = Int(myPreferences.preferencesIndex)
    }
    
    
    //2
    let tempIsGoalsSelected = CoreDataManager.manager.fetchIsGoalsSelected()
    if let tempIsGoalsSelected = tempIsGoalsSelected {
      isGoalsExists = tempIsGoalsSelected.isGoalsSelected
    }
    
  }
  
  private func setupView() {
    outletInit()
    if isGoalsExists == false {
      print("notification = false goals exists")
      prefView.cellForRow(at: IndexPath.init(row: 0, section: 0))?.accessoryType = .checkmark
    } else {
      prefView.cellForRow(at: IndexPath.init(row: savedIndex, section: 0))?.accessoryType = .checkmark
    }
  }
  
  private func outletInit() {
    self.prefView.layer.cornerRadius = 8
    self.reminderButton.layer.cornerRadius = 8
  }
}

// MARK: - Table checklist

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return periodArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = prefView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\(periodArray[indexPath.row].periodName) : \(periodArray[indexPath.row].periodStart) - \(periodArray[indexPath.row].periodFinish)"
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    prefView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    //    periodArray[indexPath[1]].periodState = true
    //print(periodArray) // Need fixed
    savedIndex = indexPath.row
    selectedHours = selectedItemDict[savedIndex]!
    print(selectedHours!)
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    prefView.cellForRow(at: indexPath)?.accessoryType = .none
    periodArray[indexPath[1]].periodState = false
    //print(periodArray)
  }
  
}

// MARK: Structs and Models
struct timePeriod {
  var periodName : String
  var periodStart : String
  var periodFinish : String
  var periodState : Bool
}

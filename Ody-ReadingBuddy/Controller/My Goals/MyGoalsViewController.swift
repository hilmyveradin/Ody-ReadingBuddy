//
//  MyGoalsViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 07/04/22.
//

import Foundation
import NotificationCenter
import UIKit

class MyGoalsViewController: UIViewController {
  
  //MARK: - Properties
  @IBOutlet weak var UIView1: UIView!
  @IBOutlet weak var UIView2: UIView!
  @IBOutlet weak var subOneUIView2: UIView!
  @IBOutlet weak var subTwoUIView2: UIView!
  @IBOutlet weak var UIView3: UIView!
  @IBOutlet weak var UIView4: UIView!
  @IBOutlet weak var blurredView: UIView!
  
  @IBOutlet weak var goalsText: UITextField!
  @IBOutlet weak var startDate: UIDatePicker!
  @IBOutlet weak var endDate: UIDatePicker!
  @IBOutlet weak var customSwitch: UISwitch!
  @IBOutlet weak var durationGoal: UIDatePicker!
  @IBOutlet weak var saveButton: UIButton!
  
  var isGoalsExists = false
  var initialWeekday = [1, 2, 3, 4, 5, 6, 7]
  var initialHours = [5, 12]
  
  var myGoals : MyGoals?
  let myGoalsisi = MyGoals()
  var isGoalsSelected : IsGoalsSelected?
  var home : Home?
  
  //MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchInLoad()
    print(isGoalsExists)
    setupView()
    requestNotificationAuth()
    navigationItem.backBarButtonItem =
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  //MARK: - Button Actions
  
  @IBAction func saveButtonPressed(_ sender: UIButton!) {
    if isGoalsExists == false {
      let alert = UIAlertController(title: "Goals Saved", message: "You have sucessfully saved your goals" , preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] _ in
        self.saveGoals()
        self.setupView()
      }))
      self.present(alert, animated: true, completion: nil)
      
    } else {
      
      let alert = UIAlertController(title: "Do You Want To End Goal?", message: "My goals can be eidted after the current goal is ended" , preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        self.resetGoals()
        self.setupView()
      }))
      self.present(alert, animated: true, completion: nil)
    }
    
  }
  
  //MARK: - Action Helpers
  
  private func saveGoals() {
    self.isGoalsExists = true
    /*
     1. masukin semua hal ke MyGoals Entitiy
     2. masukin semua hal ke Home
     3. masukin "true" ke isGoalsSelected
     4. get notifications
     */
    //1
    CoreDataManager.manager.insertGoal(goalsName: self.goalsText.text!, startDate: self.startDate.date, endDate: self.endDate.date, duration: self.durationGoal.date)
    //2
    let totalDays = self.getNumberOfDays()
    let totalSeconds = getNumberOfDuration()
    CoreDataManager.manager.insertHomeTarget(daysTarget: totalDays, timeTarget: totalSeconds)
    //3
    CoreDataManager.manager.insertIsGoalsSelected(isGoalsExists: true)
    //4
    NotificationManager.manager.monthDateFormatter(startDate: startDate.date, endDate: endDate.date)
    NotificationManager.manager.dayDateFormatter(startDate: startDate.date, endDate: endDate.date)
    NotificationManager.manager.getNotification()
    
  }
  
  private func resetGoals() {
    self.isGoalsExists = false
    /*
     1. delete home entitiy
     2. delete myGoals entitiy
     3. delete isGoalsSelected
     4. delete all notifications
     */
    //1
    CoreDataManager.manager.deleteHome()
    //2
    CoreDataManager.manager.deleteGoals()
    //3
    CoreDataManager.manager.deleteIsGoalsSelected()
    //4
    NotificationManager.manager.resetNotification()
  }
  
  func fetchInLoad() {
    /*
     1. fetch myGoals (for a placeholder)
     2. fetch isGoalsSelected (for making "blocker" appears/not)
     */
    // 1
    let tempGoals = CoreDataManager.manager.fetchGoals()
    if let tempGoals = tempGoals {
      self.goalsText.text = tempGoals.goalsName!
      self.startDate.date = tempGoals.startDate!
      self.endDate.date = tempGoals.endDate!
      self.durationGoal.date = tempGoals.duration!
      print("temp goals fetch suceed!")
    }
    //2
    let tempIsGoalsSelected = CoreDataManager.manager.fetchIsGoalsSelected()
    if let tempIsGoalsSelected = tempIsGoalsSelected {
      self.isGoalsExists = tempIsGoalsSelected.isGoalsSelected
      print("isSelected fetch succeed!")
      print("is goals exits: \(isGoalsExists)")
    }

  }
  
  
  func getNumberOfDays() -> Int16 {
    let numberofDays = Calendar.current.dateComponents([.day], from: startDate.date, to: endDate.date)
    return Int16(numberofDays.day!)
  }
  
  func getNumberOfDuration() -> Int64 {
    let numberOfSeconds = Calendar.current.dateComponents([.second], from: durationGoal.date)
    return Int64(numberOfSeconds.second!)
  }
}

// MARK: - View Helpers

extension MyGoalsViewController {
  
  private func setupView() {
    roundUIView()
    if isGoalsExists == false {
      blurredView.isHidden = true
      saveButton.backgroundColor = UIColor(named: "BoldOrange-Color", in: nil, compatibleWith: nil)
      saveButton.setTitle("Save Goal", for: .normal)
      saveButton.setTitleColor(.white, for: .normal)
    } else {
      blurredView.isHidden = false
      saveButton.backgroundColor = .white
      saveButton.setTitle("End Goal", for: .normal)
      saveButton.setTitleColor(UIColor(named: "BoldOrange-Color", in: nil, compatibleWith: nil), for: .normal)
      saveButton.layer.borderColor =  UIColor(named: "BoldOrange-Color", in: nil, compatibleWith: nil)?.cgColor
      saveButton.layer.borderWidth = CGFloat(0.5)
    }
  }
  
  private func roundUIView() {
    UIView1.layer.cornerRadius = 8
    UIView2.layer.cornerRadius = 8
    subOneUIView2.layer.cornerRadius = 5
    subTwoUIView2.layer.cornerRadius = 5
    UIView3.layer.cornerRadius = 8
    UIView4.layer.cornerRadius = 8
    saveButton.layer.cornerRadius = 8
  }
  
}

// MARK: - Notification Helpers

extension MyGoalsViewController {
  func requestNotificationAuth() {
    let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
    NotificationManager.manager.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
      if let error = error {
        print("Error: ", error)
      }
    }
  }
}

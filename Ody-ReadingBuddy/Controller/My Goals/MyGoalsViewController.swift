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
  
  var isGoalsEmpty = true
  var initialWeekday = [1, 2, 3, 4, 5, 6, 7]
  var initialHours = [5, 12]
  
  let myGoals = MyGoals()
  
  //MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    requestNotificationAuth()
  }
  
  //MARK: - Button Actions
  
  @IBAction func saveButtonPressed(_ sender: UIButton!) {
    if isGoalsEmpty {
      let alert = UIAlertController(title: "Goals Saved", message: "You have sucessfully saved your goals" , preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        self.isGoalsEmpty = false
        // Flow aplikasi
        /*
         1. masukin start date dan end date ke core data (ini pasti not null
         2. fetch from core data (nah ini yang masalah)
         
         */
        if let myGoals = CoreDataManager.manager.fetchGoals() {
          NotificationManager.manager.monthDateFormatter(startDate: self.startDate.date, endDate:  self.endDate.date)
          NotificationManager.manager.dayDateFormatter(startDate:  self.startDate.date, endDate:  self.endDate.date)
          NotificationManager.manager.getWeekdays(weekdays: myGoals.weekdays ?? self.initialWeekday)
          NotificationManager.manager.getHours(hours: myGoals.hours ?? self.initialHours)
          NotificationManager.manager.getNotification()
        }
        
        self.setupView()
      }))
      self.present(alert, animated: true, completion: nil)
      
    } else {
      
      let alert = UIAlertController(title: "Do You Want To End Goal?", message: "My goals can be eidted after the current goal is ended" , preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        self.isGoalsEmpty = true
        NotificationManager.manager.resetNotification()
        self.setupView()
        
      }))
      self.present(alert, animated: true, completion: nil)
    }
    
  }
  
  @IBAction func switchCustomPressed(_ sender: UISwitch!) {
    if customSwitch.isOn {
      performSegue(withIdentifier: "goalsToCustom", sender: sender)
    }
  }
}

// MARK: - View Helpers

extension MyGoalsViewController {
  
  private func setupView() {
    roundUIView()
    if isGoalsEmpty {
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

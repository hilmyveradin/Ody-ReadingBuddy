//
//  MyGoalsViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 07/04/22.
//

import Foundation
import UIKit

class MyGoalsViewController: UIViewController {
  
  //MARK: - Properties
  @IBOutlet weak var UIView1: UIView!
  @IBOutlet weak var UIView2: UIView!
  @IBOutlet weak var subOneUIView2: UIView!
  @IBOutlet weak var subTwoUIView2: UIView!
  @IBOutlet weak var UIView3: UIView!
  @IBOutlet weak var UIView4: UIView!
  
  @IBOutlet weak var goalsText: UITextField!
  @IBOutlet weak var startDate: UIDatePicker!
  @IBOutlet weak var endDate: UIDatePicker!
  @IBOutlet weak var customSwitch: UISwitch!
  @IBOutlet weak var durationGoal: UIDatePicker!
  @IBOutlet weak var saveButton: UIButton!
  
  
  
  //MARK: - Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    roundUIView()
  }

  @IBAction func saveButtonPressed(_ sender: UIButton!) {
    print("savebutton pressed")
    print(goalsText.text!)
    print(startDate.date)
    print(endDate.date)
    print(customSwitch.isOn)
    print(durationGoal.date)
    
    let alert = UIAlertController(title: "Goals Saved", message: "You have sucessfully saved your goals" , preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
      NSLog("The \"OK\" alert occured.")
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func switchCustomPressed(_ sender: UISwitch!) {
    if customSwitch.isOn {
      performSegue(withIdentifier: "goalsToCustom", sender: sender)
    }
  }
  
  //MARK: - Helpers
  
  private func roundUIView() {
    UIView1.layer.cornerRadius = 8
    UIView2.layer.cornerRadius = 8
    subOneUIView2.layer.cornerRadius = 5
    subTwoUIView2.layer.cornerRadius = 5
    UIView3.layer.cornerRadius = 8
    UIView4.layer.cornerRadius = 8
    saveButton.layer.cornerRadius = 8
  }
  
  func createNotification() {
    
  }
}



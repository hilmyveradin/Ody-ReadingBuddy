//
//  CustomGoalsViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 08/04/22.
//

import Foundation
import UIKit

class CustomGoalsViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.isScrollEnabled = false
    }
  }
  
  @IBOutlet weak var saveSettingButton: UIButton!
  
  var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  var daysDict = [
    "Monday": false,
    "Tuesday": false,
    "Wednesday" : false,
    "Thursday" : false,
    "Friday" : false,
    "Saturday" : false,
    "Sunday" : false
  ]
  var selectedDays = [String]()
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    saveSettingButton.layer.cornerRadius = 10
  }
  
  @IBAction func saveSettingsPressed(_ sender: UIButton!) {
    let alert = UIAlertController(title: "Custom Days Saved", message: "You have sucessfully saved your days preferences" , preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
      NSLog("The \"OK\" alert occured.")
    }))
    self.present(alert, animated: true, completion: nil)
    getSelectedDays()
  }
  
  private func getSelectedDays() {
    selectedDays = daysDict.allKeys(forValue: true)
    print(selectedDays)
  }
}


// MARK: - Talble Data Source
extension CustomGoalsViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "CUSTOM DAYS"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    days.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = days[indexPath.row]
    return cell
  }
}

// MARK: - Table Delegate
extension CustomGoalsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if daysDict[days[indexPath.row]] == true {
      daysDict[days[indexPath.row]] = false
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
      
    } else {
      daysDict[days[indexPath.row]] = true
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
  }
}



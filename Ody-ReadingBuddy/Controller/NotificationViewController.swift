//
//  NotificationViewController.swift
//  ReadingApp-Dummy
//
//  Created by Hilmy Veradin on 06/04/22.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {

  
  @IBOutlet weak var prefView: UITableView!
  @IBOutlet weak var reminderButton: UIButton!
  
  func outletInit() {
    self.prefView.layer.cornerRadius = 8
    self.reminderButton.layer.cornerRadius = 8
  }
  
  struct timePeriod {
    var periodName : String
    var periodStart : String
    var periodFinish : String
    var periodState : Bool
  }
  
  var periodArray : [timePeriod] = [
    timePeriod(periodName: "Morning", periodStart: "05.00", periodFinish: "11.59", periodState: false),
    timePeriod(periodName: "Afternoon", periodStart: "12.00", periodFinish: "15.59", periodState: false),
    timePeriod(periodName: "Evening", periodStart: "16.00", periodFinish: "19.59", periodState: false),
    timePeriod(periodName: "Night", periodStart: "20.00", periodFinish: "22.59", periodState: false),
    timePeriod(periodName: "Midnight", periodStart: "23.00", periodFinish: "04.59", periodState: false)
  ]
//  var prefState = [false, false, false, false ,false]
//
//  let Morning = timePeriod(periodStart: 05.00, periodFinish: 11.59)
//  let Afternoon = timePeriod(periodStart: 12.00, periodFinish: 15.59)
//  let Evening = timePeriod(periodStart: 16.00, periodFinish: 19.59)
//  let Night = timePeriod(periodStart: 20.00, periodFinish: 22.59)
//  let Midnight = timePeriod(periodStart: 23.00, periodFinish: 04.59)
  
//  let preferenceList = ["Morning: 05.00 - 11.59", "Afternoon: 12.00 - 15.59", "Evening: 16.00 - 19.59", "Night: 20.00 - 22.59", "Midnight: 23.00 - 04.59"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    outletInit()
  }

  @IBAction func saveReminderAction(_ sender: Any) {
    //send array data to?
    print("save reminder")
  }
  
  
}

// MARK: - Table checklist

extension NotificationViewController:UITableViewDelegate, UITableViewDataSource
{
  
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
    periodArray[indexPath[1]].periodState = true
    //print(periodArray) // Need fixed
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    prefView.cellForRow(at: indexPath)?.accessoryType = .none
    periodArray[indexPath[1]].periodState = false
    //print(periodArray)
  }
  
}

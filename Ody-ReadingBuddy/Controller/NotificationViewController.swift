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
  
  let preferenceList = ["Morning: 05.00 - 11.59", "Afternoon: 12.00 - 15.59", "Evening: 16.00 - 19.59", "Night: 20.00 - 22.59", "Midnight: 23.00 - 04.59"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.prefView.layer.cornerRadius = 10.0
  }

}
extension NotificationViewController:UITableViewDelegate, UITableViewDataSource
{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return preferenceList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = prefView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = preferenceList[indexPath.row]
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    prefView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    prefView.cellForRow(at: indexPath)?.accessoryType = .none
  }
  
  
}

//
//  MyGoalsViewController.swift
//  ReadingApp-Dummy
//
//  Created by Hilmy Veradin on 06/04/22.
//

import Foundation
import UIKit

class MyGoalsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

extension MyGoalsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
}

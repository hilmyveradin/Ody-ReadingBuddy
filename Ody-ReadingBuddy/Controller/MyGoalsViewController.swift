//
//  MyGoalsViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Hilmy Veradin on 07/04/22.
//

import Foundation
import UIKit

class MyGoalsViewController: UIViewController {
  
  @IBOutlet weak var UIView1: UIView!
  @IBOutlet weak var UIView2: UIView!
  @IBOutlet weak var UIView3: UIView!
  @IBOutlet weak var UIView4: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    roundUIView()
  }
  
  private func roundUIView() {
    UIView1.layer.cornerRadius = 8
    UIView2.layer.cornerRadius = 8
    UIView3.layer.cornerRadius = 8
    UIView4.layer.cornerRadius = 8
  }
}


//MARK: - Rounding UIView
extension MyGoalsViewController {
  
}

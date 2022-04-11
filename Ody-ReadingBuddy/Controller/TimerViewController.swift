//
//  TimerViewController.swift
//  ReadingApp-Dummy
//
//  Created by Hilmy Veradin on 06/04/22.
//

import Foundation
import UIKit




class TimerViewController: UIViewController {
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var pauseButton: UIButton!
  @IBOutlet weak  var resetButton: UIButton!
  
  var timer = Timer()
  var seconds = 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  @IBAction func startButton( sender: Any){
    
  }
  @IBAction func pauseButton( sender: Any){
    
  }
  @IBAction func resetButton( sender: Any){
    
  }


}

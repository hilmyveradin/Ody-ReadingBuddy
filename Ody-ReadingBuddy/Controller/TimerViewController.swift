//
//  TimerViewController.swift
//  ReadingApp-Dummy
//
//  Created by Hilmy Veradin on 06/04/22.
//

import Foundation
import UIKit

/*
 1. fetch Mygoals.duration (durasi total) (ini yang bakal dipake seterusnya)
 
 seandainya keluar/back dari aplikasi
 -> hasil fetch dari mygoals.duration, disimpen di current timer
 
 tiga variable:
 totalDuration = fetch di mygoals.duration
 currentDuration = fetch dari currentDuration
 
 if currentDuration != 0 {
 timer = totalDuration
 } else
 timer = currentTimer
 
 Timer
 
 
 
 
 
 
 
 totalDuration = 300
 timer = 300
 
 var totalDuration = MyGoals.duration
 var currentTimer = TimeInterface.currentTimer
 var Timer: Int!
 
 if currentTimer != 0 {
 Timer = currentTimer
 } else {
 Timer = totalDuration
 }
 
 *case keluar dari app*
 func saveCurrentTimer(Timer) -> currentTimer
 */




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

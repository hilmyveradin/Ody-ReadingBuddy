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
    timer.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.timerClass), userInfo: nil, repeats: true)
  }
  @IBAction func pauseButton( sender: Any){
    timer.invalidate()
    
  }
  @IBAction func resetButton( sender: Any){
    timer.invalidate()
    seconds = 60
    timerLabel.text = String(seconds)
  }
  
  @objc func timerClass(){
    seconds -= 1
    timerLabel.text = String(seconds)
    
    if(seconds == 0){
      timer.invalidate()
    }
  }

}

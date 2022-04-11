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
  @IBOutlet weak var pauseButton: UIButton!
  @IBOutlet weak  var resetButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  
  var timer:Timer = Timer()
  var initialVal:Int = 60
  var count:Int = 60
  var isCounting:Bool = false
  
  
  @IBAction func pauseButton(_ sender: Any){
    if (isCounting){
      isCounting = false
      timer.invalidate()
      pauseButton.setImage(UIImage(named: "play.png"), for: .normal)
    }
    else{
      isCounting = true
      pauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
  }
  @objc func timerCounter() -> Void {
    count = count - 1
    let time = secMinsHours(seconds: count)
    let timeString = timeToString(hours: time.0, minutes: time.1, seconds: time.2)
    timerLabel.text = timeString
  }
  
  func secMinsHours(seconds: Int) -> (Int, Int, Int){
    return ((seconds / 3600), ((seconds % 36000) / 60), ((seconds % 36000) % 60 ))
  }
  
  func timeToString(hours:Int, minutes:Int, seconds:Int) -> String
  {
    var timeString = ""
    timeString += String(format: "%02d", hours)
    timeString += " : "
    timeString += String(format: "%02d", minutes)
    timeString += " : "
    timeString += String(format: "%02d", seconds)
    return timeString
  }
  
  @IBAction func resetPressed(_ sender: Any) {
    
    let time2 = secMinsHours(seconds: initialVal)
    let timeString2 = timeToString(hours: time2.0, minutes: time2.1, seconds: time2.2)
    let alert = UIAlertController(title: "Reset Timer", message: "Are you sure would like to reset the Timer", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
    }))
    alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
      self.count = self.initialVal
      self.timer.invalidate()
      self.timerLabel.text = timeString2
      self.pauseButton.setImage(UIImage(named: "play.png"), for: .normal)
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
}

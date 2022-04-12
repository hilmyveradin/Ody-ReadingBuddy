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
  @IBOutlet weak var pauseButton: UIButton!
  @IBOutlet weak  var resetButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  
  var seconds = 60
  var timer = Timer()
  var isTimerRunning = true
  var resumeTapped = false
  
//  @IBAction func startButtonTapped(_ sender: UIButton){
//    if isTimerRunning == false {
//         runTimer()
//         self.startButton.isEnabled = false
//    }
//  }
  func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector:(#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    isTimerRunning = true
    pauseButton.isEnabled = true
  }
  
  @IBAction func pauseButtonTapped(_ sender: UIButton){
    if self.resumeTapped == false {
      timer.invalidate()
      self.pauseButton.setImage(UIImage(systemName:"play.fill", compatibleWith: .none), for: .normal)
      self.resumeTapped = true
      pauseButton.setTitleColor(.white, for: .normal)

    } else {
      runTimer()
      self.pauseButton.setImage(UIImage(systemName:"pause.fill", compatibleWith: .none), for: .normal)
      self.resumeTapped = false
      pauseButton.setTitleColor(UIColor(named: "BoldOrange-Color", in: nil, compatibleWith: nil), for: .normal)
    }
  }
  
  @IBAction func resetButtonTapped(_ sender: UIButton){
    timer.invalidate()
    seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
    timerLabel.text = timeString(time: TimeInterval(seconds))
    isTimerRunning = false
    self.pauseButton.setImage(UIImage(systemName:"play.fill", compatibleWith: .none), for: .normal)
  }
  
  @IBAction func stopButtonTapped(_ sender: UIButton){
    timer.invalidate()
    performSegue(withIdentifier: "toMain", sender: self)
  }
  
  @objc func updateTimer() {
    if seconds < 1 {
         timer.invalidate()
         //Send alert to indicate "time's up!"
    } else {
         seconds -= 1
         timerLabel.text = timeString(time: TimeInterval(seconds))
    }
  }
  
  func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let mascotGif = UIImage.gifImageWithName("maskotBaca")
          imageView.image = mascotGif
    runTimer()
    updateTimer()
  }
//  @IBOutlet weak var timerLabel: UILabel!
//  @IBOutlet weak var pauseButton: UIButton!
//  @IBOutlet weak  var resetButton: UIButton!
//  @IBOutlet weak var imageView: UIImageView!
//
//  var timer:Timer = Timer()
//  var initialVal:Int = 60
//  var count:Int = 60
//  var isCounting:Bool = false
//
//  override func viewDidLoad() {
//     super.viewDidLoad()
//
//     let mascotGif = UIImage.gifImageWithName("maskotBaca")
//         imageView.image = mascotGif
//   }
//
//  @IBAction func pauseButton(_ sender: Any){
//    if (isCounting){
//      isCounting = false
//      timer.invalidate()
//      pauseButton.setImage(UIImage(named: "play.png"), for: .normal)
//    }
//    else{
//      isCounting = true
//      pauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
//      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
//    }
//  }
//
//  @objc func timerCounter() -> Void {
//    count = count - 1
//    let time = secMinsHours(seconds: count)
//    let timeString = timeToString(hours: time.0, minutes: time.1, seconds: time.2)
//    timerLabel.text = timeString
//  }
//
//  func secMinsHours(seconds: Int) -> (Int, Int, Int){
//    return ((seconds / 3600), ((seconds % 36000) / 60), ((seconds % 36000) % 60 ))
//  }
//  func timeToString(hours:Int, minutes:Int, seconds:Int) -> String
//  {
//    var timeString = ""
//    timeString += String(format: "%02d", hours)
//    timeString += " : "
//    timeString += String(format: "%02d", minutes)
//    timeString += " : "
//    timeString += String(format: "%02d", seconds)
//    return timeString
//  }
//
//  @IBAction func resetPressed(_ sender: Any) {
//
//    let time2 = secMinsHours(seconds: initialVal)
//    let timeString2 = timeToString(hours: time2.0, minutes: time2.1, seconds: time2.2)
//    let alert = UIAlertController(title: "Reset Timer", message: "Are you sure would like to reset the Timer", preferredStyle: .alert)
//
//    alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
//    }))
//    alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
//      self.count = self.initialVal
//      self.timer.invalidate()
//      self.timerLabel.text = timeString2
//      self.pauseButton.setImage(UIImage(named: "play.png"), for: .normal)
//    }))
//
//    self.present(alert, animated: true, completion: nil)
//  }
//
}

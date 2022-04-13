//
//  mainViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Muhammad Abdul Fattah on 12/04/22.
//
import Foundation
import UIKit


class MainViewController: UIViewController {
  
  //MARK: - Properties
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var startBtnUI: UIButton!
  @IBOutlet weak var daySpentUI: UILabel!
  @IBOutlet weak var timeSpentUI: UILabel!
  
  // Core Data properties
  var isGoalsSelected : IsGoalsSelected?
  var home : Home?
  var leftBarButtonItem : UIBarButtonItem!
  
  var isGoalExists = false
  var timeTarget = 0
  var timeSpent = 0
  var daysTarget = 0
  var daysSpent = 0
  
  
  //MARK: - Life Cycles
  @IBAction func unwind( _ seg: UIStoryboardSegue) {
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    fetchWhenLoaded()
    //otter gif
    let mascotGif = UIImage.gifImageWithName("masccotfin")
    imageView.image = mascotGif
    
    //progress bar
    timeSpentFunction()
    daysSpentFunction()
    
    self.navigationItem.leftBarButtonItem = nil
    
    print("Main: View did load called!")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    almostOver()
  }
  
  // MARK: - Button Actions
  @IBAction func startReadingClicked(_ sender: UIButton) {
    //check goal setting
    //no goal
    if isGoalExists == true {
      print("MianView: ",isGoalExists)
      performSegue(withIdentifier: "toTimer", sender: self)
      
    } else {
      let alert = UIAlertController(title: "You haven't set any goal", message: "Set goal before you start. Please go to 'Goals' page", preferredStyle: .alert)
      alert.view.tintColor = UIColor.init(named: "BoldOrange-Color")
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
        //open goals
        
      }))
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
      
      self.present(alert, animated: true)
    }
    
  }
  
  // MARK: - Action Helpers
  
  func daysSpentFunction() {
    //draw circle
    let position = CGPoint(x: 128, y: 165)
    
    //create track layer
    let trackLayer = CAShapeLayer()
    let circularPath = UIBezierPath(arcCenter: position, radius: 40, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
    trackLayer.path = circularPath.cgPath
    
    trackLayer.strokeColor = UIColor.systemGray5.cgColor
    trackLayer.lineWidth = 8
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.lineCap = CAShapeLayerLineCap.round
    view.layer.addSublayer(trackLayer)
    
    //create progress layer
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.path = circularPath.cgPath
    
    shapeLayer.strokeColor = UIColor.orange.cgColor
    shapeLayer.lineWidth = 8
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    
    shapeLayer.strokeEnd = 0
    
    view.layer.addSublayer(shapeLayer)
    
    //create reading progress animation
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    //get data
    //    daysSpent = 25
    //    daysTarget = 50
    let progress: Double = Double(1) / Double(daysTarget) * Double(daysSpent)
    
    basicAnimation.toValue = progress
    basicAnimation.duration = 1
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "animation")
    
    //set label
    daySpentUI.text = "\(daysSpent)/\(daysTarget)"
  }
  
  func timeSpentFunction(){
    print(timeTarget)
    print(timeSpent)
    //draw circletimeTarget
    let position = CGPoint(x: 263, y: 165)
    
    //create track layer
    let trackLayer = CAShapeLayer()
    let circularPath = UIBezierPath(arcCenter: position, radius: 40, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
    trackLayer.path = circularPath.cgPath
    
    trackLayer.strokeColor = UIColor.systemGray5.cgColor
    trackLayer.lineWidth = 8
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.lineCap = CAShapeLayerLineCap.round
    view.layer.addSublayer(trackLayer)
    
    //create progress layer
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.path = circularPath.cgPath
    
    shapeLayer.strokeColor = UIColor.orange.cgColor
    shapeLayer.lineWidth = 8
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    
    shapeLayer.strokeEnd = 0
    
    view.layer.addSublayer(shapeLayer)
    
    //create reading progress animation
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    //get data
    //    timeSpent = 10
    //    timeTarget = 15
    var progress: Double!
    if timeSpent > 0 {
      progress = Double(1) / Double(timeTarget) * (Double(timeTarget)-Double(timeSpent))
    } else {
      progress = Double(0)
    }
    
//    print(progress)
    
    basicAnimation.toValue = progress
    basicAnimation.duration = 1
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "animation")
    
    //set label
    if timeSpent <= 60 && timeSpent > 0 {
      print("1")
      timeSpentUI.text = "\(timeSpent)s"
    }
    else if 60 < timeSpent && timeSpent < 3600  && timeSpent > 0 {
      print("2")
      let minutes = timeSpent/60%60
      timeSpentUI.text = "\(minutes)m"
    }
    else if timeSpent > 3600 && timeSpent > 0 {
      print("3")
      let hour = timeSpent/3600
      timeSpentUI.text = "\(hour)h"
    } else if timeTarget <= 60 {
      print("4")
      timeSpentUI.text = "\(timeTarget)s"
    } else if timeTarget > 60 && timeTarget < 3600 {
      print("5")
      let minutes = timeTarget/60%60
      timeSpentUI.text = "\(minutes)m"
    } else {
      print("6")
      let hour = timeTarget/3600
      timeSpentUI.text = "\(hour)h"
    }
  }
  
  func fetchWhenLoaded() {
    /*
     1. fetch isGoalsSelected
     2. fetch Home
     */
    
    //1
    
    
    let tempIsGoalsSelected = CoreDataManager.manager.fetchIsGoalsSelected()
    let home = CoreDataManager.manager.fetchHome()
    
    guard let tempIsGoalsSelected = tempIsGoalsSelected,
    let home = home else {
       timeTarget = 0
       timeSpent = 0
       daysTarget = 0
       daysSpent = 0
      isGoalExists = false
      return
    }

  
      self.isGoalExists = tempIsGoalsSelected.isGoalsSelected
      print("Main: isSelected fetch succeed!")
      print("Main: is goals exits: \(isGoalExists)")

      self.daysTarget = Int(home.daysTarget)
      self.daysSpent = Int(home.daysSpent)
      self.timeTarget = Int(home.timeTarget)
      self.timeSpent = Int(home.timeSpent)
      print("Main: Home fetch succeed!")
    
    

  }
  
  private func almostOver() {
    if daysSpent == daysTarget-1 && timeTarget != 0{
      let alert = UIAlertController(title: "One Day Left!", message: "Tomorrow is your last day in this goal. Keep it up!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Sure!", style: .default))
      self.present(alert, animated: true, completion: nil)
    } else if daysSpent == daysTarget && timeTarget != 0 {
      let alert = UIAlertController(title: "Target Finished!", message: "You have finished your current goal. Let's set another goal!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [self] _ in
        resetGoal()
      }))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  private func resetGoal() {
    /*
     1. delete home entitiy
     2. delete myGoals entitiy
     3. delete isGoalsSelected
     4. delete timer
     5. delete preferences
     7. delete current Day
     6. reset notifications
     
     */
    //1
    CoreDataManager.manager.deleteHome()
    //2
    CoreDataManager.manager.deleteGoals()
    //3
    CoreDataManager.manager.deleteIsGoalsSelected()
    //4
    CoreDataManager.manager.deleteTimer()
    //5
    CoreDataManager.manager.deletePreferences()
    //6
    CoreDataManager.manager.deleteCurrentDay()
    //7
    CoreDataManager.manager.deleteWeekday()
    //6
    NotificationManager.manager.resetNotification()
  }
  
  //  @IBOutlet weak var mainImageView: UIImageView!
  //
  //  let shapeLayer = CAShapeLayer()
  //
  //  override func viewDidLoad() {
  //     super.viewDidLoad()
  //     let maskotGif = UIImage.gifImageWithName("mascotfin")
  //         mainImageView.image = maskotGif
  //
  //
  //    let center = view.center
  //
  //    // track layer
  //    let trackLayer = CAShapeLayer()
  //    let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
  //    trackLayer.path = circularPath.cgPath
  //    trackLayer.strokeColor = UIColor.lightGray.cgColor
  //    trackLayer.lineWidth = 10
  //    trackLayer.fillColor = UIColor.clear.cgColor
  //    trackLayer.lineCap = CAShapeLayerLineCap.round
  //
  //    view.layer.addSublayer(trackLayer)
  //
  //    //
  //
  //   // let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
  //    shapeLayer.path = circularPath.cgPath
  //    shapeLayer.strokeColor = UIColor.orange.cgColor
  //    shapeLayer.lineWidth = 10
  //    shapeLayer.fillColor = UIColor.clear.cgColor
  //
  //    shapeLayer.lineCap = CAShapeLayerLineCap.round
  //
  //    shapeLayer.strokeEnd = 0
  //
  //    view.layer.addSublayer(shapeLayer)
  //    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
  //   }
  //
  //  @objc private func handleTap(){
  //
  //    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
  //    basicAnimation.toValue = 1
  //    basicAnimation.duration = 1
  //    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
  //    basicAnimation.isRemovedOnCompletion = false
  //
  //    shapeLayer.add(basicAnimation, forKey:"urSoBasic")
  //  }
}

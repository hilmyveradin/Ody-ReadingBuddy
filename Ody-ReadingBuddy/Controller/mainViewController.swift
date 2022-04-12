//
//  mainViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Muhammad Abdul Fattah on 12/04/22.
//

import Foundation
import UIKit


class mainViewController: UIViewController {
  
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var startBtnUI: UIButton!
  
  @IBOutlet weak var daySpentUI: UILabel!
  @IBOutlet weak var timeSpentUI: UILabel!
  
  var isGoalExist = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    //otter gif
    let mascotGif = UIImage.gifImageWithName("masccotfin")
    imageView.image = mascotGif
     
    //progress bar
    timeSpent()
    daysSpent()
    
  }
  
  @IBAction func startReadingClicked(_ sender: UIButton) {
    //check goal setting
    //no goal
    if isGoalExist == true{
      performSegue(withIdentifier: "toTimer", sender: self)

    }else{
      let alert = UIAlertController(title: "You haven't set any goal", message: "Set goal before you start. Go to 'Goals'?", preferredStyle: .alert)

      alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { action in
        //open goals
        
        }))
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

      self.present(alert, animated: true)
    }

  }
  
  func daysSpent(){
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
    var realization = 25
    var target = 50
    var progress: Double = Double(1) / Double(target) * Double(realization)
    
    basicAnimation.toValue = progress
    basicAnimation.duration = 1
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "animation")
    
    //set label
    daySpentUI.text = "\(realization)/\(target)"
  }
  
  func timeSpent(){
    //draw circle
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
    var realization = 10
    var target = 15
    var progress: Double = Double(1) / Double(target) * Double(realization)
    
    basicAnimation.toValue = progress
    basicAnimation.duration = 1
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "animation")
    
    //set label
    timeSpentUI.text = "\(realization)m"
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

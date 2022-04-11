//
//  mainViewController.swift
//  Ody-ReadingBuddy
//
//  Created by Muhammad Abdul Fattah on 12/04/22.
//

import Foundation
import UIKit


class mainViewController: UIViewController {
  
  @IBOutlet weak var mainImageView: UIImageView!
  
  let shapeLayer = CAShapeLayer()
  
  override func viewDidLoad() {
     super.viewDidLoad()
     let maskotGif = UIImage.gifImageWithName("mascotfin")
         mainImageView.image = maskotGif
    
   
    let center = view.center
    
    // track layer
    let trackLayer = CAShapeLayer()
    let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
    trackLayer.path = circularPath.cgPath
    trackLayer.strokeColor = UIColor.lightGray.cgColor
    trackLayer.lineWidth = 10
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.lineCap = CAShapeLayerLineCap.round
    
    view.layer.addSublayer(trackLayer)
    
    //
    
   // let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
    shapeLayer.path = circularPath.cgPath
    shapeLayer.strokeColor = UIColor.orange.cgColor
    shapeLayer.lineWidth = 10
    shapeLayer.fillColor = UIColor.clear.cgColor
    
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    
    shapeLayer.strokeEnd = 0
    
    view.layer.addSublayer(shapeLayer)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
   }

  @objc private func handleTap(){
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.toValue = 1
    basicAnimation.duration = 1
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey:"urSoBasic")
  }
}

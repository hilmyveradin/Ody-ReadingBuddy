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
  
  
  override func viewDidLoad() {
     super.viewDidLoad()
     let maskotGif = UIImage.gifImageWithName("mascotfin")
         mainImageView.image = maskotGif
   }
  
}

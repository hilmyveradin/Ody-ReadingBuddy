//
//  OnBoardingViewController.swift
//  ReadingApp-Dummy
//
//  Created by Hilmy Veradin on 06/04/22.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {

  //Outlets
  @IBOutlet weak var imageUI: UIImageView!
  @IBOutlet weak var imageTitleUI: UILabel!
  @IBOutlet weak var imageDescUI: UITextView!
  @IBOutlet weak var pageControlUI: UIPageControl!
  @IBOutlet weak var startBtnUI: UIButton!
  @IBOutlet weak var nextBtnUI: UIButton!
  @IBOutlet weak var backBtnUI: UIButton!
  @IBOutlet weak var skipBtnUI: UIButton!
      
  //Data
  var onBoardings: [OnBoarding] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    //generate data
    var onBoardingData = OnBoarding()
    onBoardings = onBoardingData.generateOnBoarding()
    
    //set up
    setUpPage(index: 0)
  }
  
  @IBAction func nextClicked(_ sender: UIButton) {
    //go to the next page
    pageControlUI.currentPage += 1
    
    //set page
    setUpPage(index: pageControlUI.currentPage)
  }
      
  @IBAction func backClicked(_ sender: UIButton) {
    //go to the previous page
    pageControlUI.currentPage -= 1
    
    //set page
    setUpPage(index: pageControlUI.currentPage)
  }
    
  @IBAction func skipClicked(_ sender: UIButton) {
    var lastPage = pageControlUI.numberOfPages - 1
    
    //move to last page
    pageControlUI.currentPage = lastPage

    //set page
    setUpPage(index: lastPage)
      
  }
    
  @IBAction func startClicked(_ sender: UIButton) {
      //open timer page
  }
  
  func setUpPage(index: Int) {
    //page data
    imageUI.image = onBoardings[index].image
    imageTitleUI.text = onBoardings[index].imageTitle
    imageDescUI.text = onBoardings[index].imageDesc
    
    //show/hide button
    startBtnUI.isHidden = onBoardings[index].startBtnHidden
    backBtnUI.isHidden = onBoardings[index].backBtnHidden
    nextBtnUI.isHidden = onBoardings[index].nextBtnHidden
    skipBtnUI.isHidden = onBoardings[index].skipBtnHidden
  }

}

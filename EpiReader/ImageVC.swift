//
//  ImageVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 08/06/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class ImageVC: UIViewController, UIGestureRecognizerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  var image = UIImage()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDismissTouch()
    imageView.image = image
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = imageView.bounds.size.height / 2
    imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    imageView.layer.borderWidth = 2
  }
  
  fileprivate func setUpDismissTouch() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert))
    tap.numberOfTapsRequired = 1
    tap.delegate = self
    self.view.addGestureRecognizer(tap)
  }
  
  func dismissAlert() {
    self.dismiss(animated: true, completion: nil)
  }
}

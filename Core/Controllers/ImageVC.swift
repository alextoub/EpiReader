//
//  ImageVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 08/06/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class ImageVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Variables

    @IBOutlet weak var imageView: UIImageView!
    var image = UIImage()
    
    var student = Student()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var promoLabel: UILabel!
    
    @IBOutlet weak var promoView: UIView!
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDismissTouch()
        imageView.image = image
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.size.height / 2
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        imageView.layer.borderWidth = 4
        
        if student.lastName != nil {
            nameLabel.text = student.firstName! + " " + student.lastName!
            loginLabel.text = student.login!
            mailLabel.text = student.mail!
            promoLabel.text = student.promo!
            promoLabel.textColor = UIColor(string: student.promo!)
            promoView.layer.borderColor = UIColor(string: student.promo!).cgColor
            
        }
    }
    
    // MARK: - Custom functions
    
    fileprivate func setUpDismissTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}

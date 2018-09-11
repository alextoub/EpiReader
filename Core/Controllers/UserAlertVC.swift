//
//  UserAlertVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 11/09/2018.
//  Copyright © 2018 Alexandre Toubiana. All rights reserved.
//

import UIKit

class UserAlertVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage? = nil
    var student: Student? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var promoLabel: UILabel!
    @IBOutlet weak var promoView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDismissTouch()
        setupView()
        animateView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        configureView()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func configureView() {
        if let image = image {
            imageView.image = image
        }
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.size.height / 2
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        imageView.layer.borderWidth = 4
        
        if let student = self.student {
            nameLabel.text  = (student.firstName ?? "") + " " + (student.lastName ?? "")
            loginLabel.text = student.login ?? ""
            mailLabel.text  = student.mail ?? ""
            
            if let promo = student.promo {
                promoLabel.text = promo
                promoLabel.textColor = UIColor(string: promo)
                promoView.layer.borderColor = UIColor(string: promo).cgColor
            }
            else {
                promoLabel.text = ""
                promoView.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    public func configure(student: Student?, imageStudent: UIImage?) {
        self.student = student
        self.image = imageStudent
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    fileprivate func setUpDismissTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissAlert() {
        self.dismiss(animated: true)
    }
}


extension UIViewController {
    func showUserAlert(student: Student?, imageStudent: UIImage?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let customAlert = storyboard.instantiateViewController(withIdentifier: "UserAlertVC") as! UserAlertVC
        customAlert.configure(student: student, imageStudent: imageStudent)
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
}

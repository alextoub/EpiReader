//
//  TagAlertVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 26/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class TagAlertVC: UIViewController, UIGestureRecognizerDelegate  {
    
    // MARK: - Variables & IBOutlets

    var tagName = ""
    var tagColor = UIColor()

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDismissTouch()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.bounds.height / 2
    
        tagLabel.text = tagName
        colorView.backgroundColor = tagColor
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

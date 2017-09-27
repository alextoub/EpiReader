//
//  TagAlertVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 26/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class TagAlertVC: UIViewController, UIGestureRecognizerDelegate  {
    
    var tagName = ""
    var tagColor = UIColor()
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var tagLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDismissTouch()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.bounds.height / 2
    
        tagLabel.text = tagName
        colorView.backgroundColor = tagColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

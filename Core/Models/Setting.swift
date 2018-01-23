//
//  Setting.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 21/01/2018.
//  Copyright © 2018 Alexandre Toubiana. All rights reserved.
//

import Foundation
import UIKit

class Setting {
    var title = ""
    var color = UIColor()
    var image = UIImage()
    var viewPush = ""
    var isSwitchable = false
    var key = ""
    
    init(title: String, color: UIColor, image: UIImage, viewPush: String = "", isSwitchable: Bool = false, key: String = "") {
        self.title = title
        self.color = color
        self.image = image
        self.viewPush = viewPush
        self.isSwitchable = isSwitchable
        self.key = key
    }
}


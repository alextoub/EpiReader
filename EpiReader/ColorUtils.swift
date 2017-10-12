//
//  ColorUtils.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/24/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import UIKit


public func getRandomColor() -> UIColor {
    let randomRed = Int(arc4random_uniform(UInt32(255)))
    let randomGreen = Int(arc4random_uniform(UInt32(255)))
    let randomBlue = Int(arc4random_uniform(UInt32(255)))
    let color = UIColor(red: CGFloat(CGFloat(randomRed)/255.0),
                        green: CGFloat(CGFloat(randomGreen)/255.0),
                        blue: CGFloat(CGFloat(randomBlue)/255.0), alpha: 1.0)
    return color
}

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    
    convenience init(string: String) {
        let data = string.sha256()
        let index = data.index(data.startIndex, offsetBy: 6)
        self.init(hex: String(data.prefix(upTo: index)))
        
    }
}

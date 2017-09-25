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

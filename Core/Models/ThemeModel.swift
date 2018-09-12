//
//  ThemeModel.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 12/09/2018.
//  Copyright © 2018 Alexandre Toubiana. All rights reserved.
//

import UIKit

public class Theme {
    
    /// All theme types
    public static let availableThemes: [Theme] = [Theme(), DarkMode()]
    
    /// Name of the theme
    public var name                   = "Main theme"
    public var backgroundColor        = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    public var navigationColor        = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    public var navigationTextColor    = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public var backGroundCell         = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    public var readIndicator          = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
    public var titleColor             = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public var subtitleColor          = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
    public var authorColor            = #colorLiteral(red: 0.3607843137, green: 0.368627451, blue: 0.4, alpha: 1)
    public var numberAnswersColor     = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)

    public init(){
    }
    
    public static func loadTheme() {
//        StaticData.themeModified = true
//        if let name = UserDefaults.standard.string(forKey: Constants.THEME) {
//            for theme in availableThemes {
//                if theme.name == name {
//                    StaticData.theme = theme
//                    return
//                }
//            }
//        }
//        UserDefaults.standard.set("Main theme", forKey: Constants.THEME)
//        StaticData.theme = Theme()
        
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        if isDarkMode {
            StaticData.theme = DarkMode()
        }
        else {
            StaticData.theme = Theme()
        }
    }
}

public class DarkMode : Theme {
    
    public override init() {
        super.init()
        name                   = "darkMode"
        backgroundColor        = #colorLiteral(red: 0.07843137255, green: 0.1176470588, blue: 0.1450980392, alpha: 1)
        navigationColor        = #colorLiteral(red: 0.1490196078, green: 0.2039215686, blue: 0.2745098039, alpha: 1)
        navigationTextColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backGroundCell         = #colorLiteral(red: 0.1058823529, green: 0.1568627451, blue: 0.2039215686, alpha: 1)
        readIndicator          = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
        titleColor             = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subtitleColor          = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        authorColor            = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        numberAnswersColor     = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
    }
}

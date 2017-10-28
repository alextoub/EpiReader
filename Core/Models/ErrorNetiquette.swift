//
//  ErrorNetiquette.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/24/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class ErrorNetiquette {
    
    var errors = [String]()
    var warnings = [String]()
    
    init(errors: [String], warnings: [String]) {
        self.errors = errors
        self.warnings = warnings
    }


}

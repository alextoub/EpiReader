//
//  Tag.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 23/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import UIKit

class Tag: NSObject, NSCoding {
    
    //MARK: Properties
    
    var tagName: String?
    var attributedColor: UIColor?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tag")
    
    //MARK: Types
    
    struct PropertyKey {
        static let tagName = "CtagName"
        static let attributedColor = "CattributedColor"
    }
    
    //MARK: Initialization
    
    init(tagName: String, attributedColor: UIColor) {
        self.tagName = tagName
        self.attributedColor = attributedColor
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tagName, forKey: PropertyKey.tagName)
        aCoder.encode(attributedColor, forKey: PropertyKey.attributedColor)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let tagName = aDecoder.decodeObject(forKey: PropertyKey.tagName) as? String
        let attributedColor = aDecoder.decodeObject(forKey: PropertyKey.attributedColor) as? UIColor
        self.init(tagName: tagName!, attributedColor: attributedColor!)
    }
}

//
//  ReadNews.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 22/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class ReadNews: NSObject, NSCoding {
  
  //MARK: Properties
  
  var id: Int?
  
  //MARK: Archiving Paths
  
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("readnews")
  
  //MARK: Types
  
  struct PropertyKey {
    static let id = "Cid"
  }
  
  //MARK: Initialization
  
  init(id: Int) {
    self.id = id
  }
  
  //MARK: NSCoding
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: PropertyKey.id)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? Int
    self.init(id: id!)
  }
}

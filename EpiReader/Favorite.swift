//
//  Favorite.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class Favorite: NSObject, NSCoding {
  
  //MARK: Properties
  
  var id: Int?
  var group_name: String?
  var topic_nb: Int?
  var available: Bool?
  
  //MARK: Archiving Paths
  
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("favorites")
  
  //MARK: Types
  
  struct PropertyKey {
    static let id = "Cid"
    static let group_name = "Cgroup_name"
    static let topic_nb = "Ctopic_nb"
    static let available = "Cavailable"
  }
  
  //MARK: Initialization
  
  init(id: Int, group_name: String, topic_nb: Int, available: Bool) {
    self.id = id
    self.group_name = group_name
    self.topic_nb = topic_nb
    self.available = available
  }
  
  //MARK: NSCoding
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: PropertyKey.id)
    aCoder.encode(group_name, forKey: PropertyKey.group_name)
    aCoder.encode(topic_nb, forKey: PropertyKey.topic_nb)
    aCoder.encode(available, forKey: PropertyKey.available)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? Int
    let group_name = aDecoder.decodeObject(forKey: PropertyKey.group_name) as? String
    let topic_nb = aDecoder.decodeObject(forKey: PropertyKey.topic_nb) as? Int
    let available = aDecoder.decodeObject(forKey: PropertyKey.available) as? Bool
    self.init(id: id!, group_name: group_name!, topic_nb: topic_nb!, available: available!)
  }
}

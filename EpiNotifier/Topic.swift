//
//  Topic.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import ObjectMapper

class Topic: Mappable {
  
  // MARK: - Attributes
  
  var id: Int?
  var uid: String?
  var author: String?
  var subject: String?
  var content: String?
  var creation_date: String?
  var groups: [String]?
  var children: [Topic]?

  // MARK: - ObjectMapper functions
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    self.id            <- map["id"]
    self.uid           <- map["uid"]
    self.author        <- map["author"]
    self.subject       <- map["subject"]
    self.content       <- map["content"]
    self.creation_date <- map["creation_date"]
    self.groups        <- map["groups"]
    self.children      <- map["children"]
  }
}

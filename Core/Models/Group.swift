//
//  Group.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import ObjectMapper

public class Group: Mappable {
    
    // MARK: - Attributes
    
    var id: Int?
    var group_name: String?
    var topic_nb: Int?
    var available: Bool?
    
    // MARK: - ObjectMapper functions
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.id         <- map["id"]
        self.group_name <- map["group_name"]
        self.topic_nb   <- map["topic_nb"]
        self.available  <- map["available"]
    }
}

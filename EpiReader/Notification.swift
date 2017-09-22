//
//  Notification.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import ObjectMapper

class NotificationSub: Mappable {
    
    // MARK: - Attributes
    
    var added: [String]?
    
    // MARK: - ObjectMapper functions
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.added            <- map["added"]
    }
}

class NotificationUnsub: Mappable {
    
    // MARK: - Attributes
    
    var removed: [String]?
    
    // MARK: - ObjectMapper functions
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.removed            <- map["removed"]
    }
}


public class NotificationGroups: Mappable {
    
    // MARK: - Attributes
    
    var subscribed_groups: [String]?
    
    // MARK: - ObjectMapper functions
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.subscribed_groups            <- map["subscribed_groups"]
    }
}

//
//  Notification.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

class NotificationSub: Codable {
    
    // MARK: - Attributes
    
    var added: [String]?
    
    // MARK: - Coding Keys
    
    private enum CodingKeys: String, CodingKey {
        case added
    }
    
    // MARK: - ObjectMapper functions
    
//    required init?(map: Map) {
//    }
//
//    func mapping(map: Map) {
//        self.added            <- map["added"]
//    }
}

class NotificationUnsub: Codable {
    
    // MARK: - Attributes
    
    var removed: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case removed
    }
    // MARK: - ObjectMapper functions
    
//    required init?(map: Map) {
//    }
//
//    func mapping(map: Map) {
//        self.removed            <- map["removed"]
//    }
}


public class NotificationGroups: Codable {
    
    // MARK: - Attributes
    
    var subscribed_groups: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case subscribed_groups
    }
    
    // MARK: - ObjectMapper functions
    
//    required public init?(map: Map) {
//    }
//    
//    public func mapping(map: Map) {
//        self.subscribed_groups            <- map["subscribed_groups"]
//    }
}

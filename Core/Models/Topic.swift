//
//  Topic.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class Topic: Codable {
    
    // MARK: - Attributes
    
    var id:             Int?
    var uid:            String?
    var author:         String?
    var subject:        String?
    var content:        String?
    var creation_date:  String?
    var groups:         [String]?
    var children:       [Topic]?
    
    // MARK: - Coding Keys
    
    private enum CodingKeys: String, CodingKey {
        case id
        case uid
        case author
        case subject
        case content
        case creation_date
        case groups
        case children
    }
    
//    // MARK: - ObjectMapper functions
//
//    required init?(map: Map) {
//    }
//
//    func mapping(map: Map) {
//        self.id            <- map["id"]
//        self.uid           <- map["uid"]
//        self.author        <- map["author"]
//        self.subject       <- map["subject"]
//        self.content       <- map["content"]
//        self.creation_date <- map["creation_date"]
//        self.groups        <- map["groups"]
//        self.children      <- map["children"]
//    }
//
    init(id: Int?, uid: String?, author: String?, subject: String?, content: String?, creation_date: String?, groups: [String]?) {
        self.id = id
        self.uid = uid
        self.author = author
        self.subject = subject
        self.content = content
        self.creation_date = creation_date
        self.groups = groups
        self.children = nil

    }
}

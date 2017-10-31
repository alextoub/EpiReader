//
//  News.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import ObjectMapper

class News: Mappable {
    
    // MARK: - Attributes
    
    var id: Int?
    var uid: String?
    var author: String?
    var subject: String?
    var creation_date: String?
    var msg_nb: Int?
    var groups: [String]?
    var isRead: Bool?
    
    // MARK: - ObjectMapper functions
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id            <- map["id"]
        self.uid           <- map["uid"]
        self.author        <- map["author"]
        self.subject       <- map["subject"]
        self.creation_date <- map["creation_date"]
        self.msg_nb        <- map["msg_nb"]
        self.groups        <- map["groups"]
    }
    
    func toStory() -> Story {
        let imageView = UIImageView()
        let url = getProfilePic(mail: parseAuthor((self.author)!)[1], subject: self.subject!)
        let story = Story(userImageUrl: url!, userName: author ?? "", newsgroup: "test")
        return story
    }
}

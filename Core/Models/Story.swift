//
//  Story.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 30/10/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import UIKit

class Story {
    
    var userImageUrl: URL?
    var userName: String?
    var newsgroup: String?
    
    init(userImageUrl: URL, userName: String, newsgroup: String) {
        self.userImageUrl = userImageUrl
        self.userName = userName
        self.newsgroup = newsgroup
    }
}

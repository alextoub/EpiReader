//
//  Group.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

public class Group: Codable {
    
    // MARK: - Attributes
    
    var id:             Int?
    var group_name:     String?
    var topic_nb:       Int?
    var available:      Bool?
    
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case id
        case group_name
        case topic_nb
        case available
    }
}

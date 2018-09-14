//
//  Student.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 19/11/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

//import ObjectMapper

public class Student: Codable {
    
    // MARK: - Attributes
    
    var login:      String?
    var lastName:   String?
    var firstName:  String?
    var mail:       String?
    var promo:      String?
    var uidNumber:  String?
    var gidNumber:  String?
    var classGroup: String?
    var photo:      String?
    
    // MARK: - Coding Keys
    
    
    private enum CodingKeys: String, CodingKey {
        case login      = "Login"
        case lastName   = "Last Name"
        case firstName  = "First Name"
        case mail       = "Mail"
        case promo      = "Promo"
        case uidNumber
        case gidNumber
        case classGroup = "Class Groups"
        case photo      = "Photo"
    }
    
    // MARK: - ObjectMapper functions
    
//    required public init?(map: Map) {
//    }
    
    init() {
        self.login = nil
        self.lastName = nil
        self.firstName = nil
        self.mail = nil
        self.promo = nil
        self.uidNumber = nil
        self.gidNumber = nil
        self.classGroup = nil
        self.photo = nil
    }
    
//    public func mapping(map: Map) {
//        self.login      <- map["Login"]
//        self.lastName   <- map["Last Name"]
//        self.firstName  <- map["First Name"]
//        self.mail       <- map["Mail"]
//        self.promo      <- map["Promo"]
//        self.uidNumber  <- map["uidNumber"]
//        self.gidNumber  <- map["gidNumber"]
//        self.classGroup <- map["Class Groups"]
//        self.photo      <- map["Photo"]
//    }
}


//
//  Constants.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    struct Url {
        static let ENTRY_API_URL = "https://ng-notifier.42portal.com/api/"        //GET
        static let TOPICS        = "topic/"                                       //GET
        static let NEWS          = "news.epita.fr/"                               //GET
    }
    
    struct AdMob {
        static let unitID = "ca-app-pub-8988229405805930/1930088334"
    }
}

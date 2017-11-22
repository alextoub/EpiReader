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
        static let NOTIF_GROUPS  = "subscribed_groups"                            //GET
        static let SEARCH        = "search"                                       //GET
        static let LAST          = "last"                                         //GET
        static let NOTIF_SUB     = "subscribe_notifications"                      //POST
        static let NOTIF_UNSUB   = "unsubscribe_notifications"                    //POST
        static let LIMIT         = "?limit="                                      //HELPER
        static let TERM          = "?term="                                       //HELPER
        
    }
    
    struct Headers {
        static let headers: HTTPHeaders = [
            "KEY": Hidden.API_KEY
        ]
    }
    
    struct Hidden {
        static let API_KEY        = ""
        static let STUDENTS_URL   = ""
    }
    
    struct AdMob {
        static let unitID = "ca-app-pub-8988229405805930/1930088334"
    }
}

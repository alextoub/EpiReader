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
        static let NOTIF_SUB     = "subscribe_notifications"                      //POST
        static let NOTIF_UNSUB   = "unsubscribe_notifications"                    //POST
        static let NOTIF_GROUPS  = "subscribed_groups"                            //GET
    }
    
    struct Headers {
        static let Api_Key =                      ""
        static let headers: HTTPHeaders = [
            "KEY": Headers.Api_Key
        ]
    }
}

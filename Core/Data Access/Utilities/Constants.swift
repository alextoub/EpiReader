//
//  Constants.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

struct Constants {
    struct Url {
        static let ENTRY_API_URL = "https://ng-notifier.42portal.com/api/"        //GET
        static let TOPICS        = "topic/"                                       //GET
        static let NEWS          = "news.epita.fr/"                               //GET
        static let NOTIF_SUB     = "subscribe_notifications"                      //POST
        static let NOTIF_UNSUB   = "unsubscribe_notifications"                    //POST
        static let NOTIF_GROUPS  = "subscribed_groups"                            //GET
        static let SEARCH        = "search?term="                                 //GET
    }
    
    struct Headers {
        static let Api_Key =                      ""
        static let headers: HTTPHeaders = [
            "KEY": Headers.Api_Key
        ]
    }
    
    struct AdMob {
        static let unitID = "ca-app-pub-8988229405805930/1930088334"
    }
}

struct Assistant {
    static let ACU = [2017 : #imageLiteral(resourceName: "acu_2018")]
    static let YAKA = [2017 : #imageLiteral(resourceName: "yaka_2018"), 2018 : #imageLiteral(resourceName: "yaka_2019")]
}

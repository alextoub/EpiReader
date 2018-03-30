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
    
    static let settings: [Setting] = [
        Setting(title: "Notifications", color: #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1), image: #imageLiteral(resourceName: "notification_logo"), viewPush: "NotificationTVC"),
        Setting(title: "Balises", color: #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2784313725, alpha: 1), image: #imageLiteral(resourceName: "tags_logo"), viewPush: "TagsTVC"),
        Setting(title: "Vérifier nétiquette [BETA]", color: #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1), image: #imageLiteral(resourceName: "netiquette_logo"), isSwitchable: true, key: "CNEnabled")]
}

struct Assistant {
    static let ACU = [2017 : #imageLiteral(resourceName: "acu_2018")]
    static let YAKA = [2017 : #imageLiteral(resourceName: "yaka_2018"), 2018 : #imageLiteral(resourceName: "yaka_2019")]
}

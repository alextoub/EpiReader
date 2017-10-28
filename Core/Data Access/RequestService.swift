//
//  RequestService.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 21/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import Alamofire

class RequestService {
    public func getGroups(){
        MainBusiness.getGroups { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    StaticData.allGroups = response!
                }
            }
        }
    }
    
    public func postSubscribedGroups(){
        print((UIDevice.current.identifierForVendor?.uuidString)!)
        MainBusiness.postSubscribedGroups(service: "ios", registration_id: StaticData.deviceToken, host: "news.epita.fr") { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    let resp = response!
                    StaticData.notificationsGroups = resp.subscribed_groups!
                }
            }
        }
    }
}

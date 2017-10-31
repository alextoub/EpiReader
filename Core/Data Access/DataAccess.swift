//
//  DataAccess.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

// MARK: - Router

private enum Router {
    case getGroups()
    case getTopics(Int)
    case getNews(String, Int)
    case getNewsWithDate(String, Int, String)
    case postSubscribeNotification(String, String, String, String)
    case postUnsubscribeNotification(String, String, String, String)
    case postSubscribedGroups(String, String, String)
    case getSearch(String)
    case getLastNews(Int)
}

extension Router : RouterProtocol {
    
    //MARK: - API Method
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getGroups:
            return .get
        case .getTopics:
            return .get
        case .getNews:
            return .get
        case .getNewsWithDate:
            return .get
        case .postSubscribeNotification:
            return .post
        case .postUnsubscribeNotification:
            return .post
        case .postSubscribedGroups:
            return .post
        case .getSearch:
            return .get
        case .getLastNews:
            return .get
        }
    }
    // MARK: - API Path
    var path: String {
        switch self {
        case .getGroups:
            return Constants.Url.ENTRY_API_URL + Constants.Url.NEWS
        case .getTopics(let id):
            return Constants.Url.ENTRY_API_URL + Constants.Url.TOPICS + "/" + String(id)
        case .getNews(let group, let nb):
            return Constants.Url.ENTRY_API_URL + Constants.Url.NEWS + group + Constants.Url.LIMIT + String(nb)
        case .getNewsWithDate(let group, let nb, let date):
            return Constants.Url.ENTRY_API_URL + Constants.Url.NEWS + group + Constants.Url.LIMIT + String(nb) + "&start_date=" + date + "%2B0000"
        case .postSubscribeNotification:
            return Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_SUB
        case .postUnsubscribeNotification:
            return Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_UNSUB
        case .postSubscribedGroups:
            return Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_GROUPS
        case .getSearch(let term):
            return Constants.Url.ENTRY_API_URL + Constants.Url.SEARCH + Constants.Url.TERM + term
        case .getLastNews(let nb):
            return Constants.Url.ENTRY_API_URL + Constants.Url.NEWS + Constants.Url.LAST + Constants.Url.LIMIT + String(nb)
        }
    }
    
    fileprivate var headers: HTTPHeaders {
        return Constants.Headers.headers
    }
}

// MARK: - Router request

extension Router: URLRequestConvertible {
    public func asURLRequest () throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: self.path)!)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
}

// MARK: - Class Main Data

class MainData {
    static func getGroups(completed: @escaping ((_ response:[Group]?, _ error:Error?) -> Void)) -> Void {
        Alamofire.request(Router.getGroups())
            .validate()
            .responseArray { (alamoResponse: DataResponse<[Group]>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getTopics(id: Int, completed: @escaping ((_ response:Topic?, _ error:Error?) -> Void)) -> Void {
        Alamofire.request(Router.getTopics(id))
            .validate()
            .responseObject { (alamoResponse: DataResponse<Topic>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getNews(group: String, nb: Int, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Alamofire.request(Router.getNews(group, nb))
            .validate()
            .responseArray { (alamoResponse: DataResponse<[News]>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getNewsWithDate(group: String, nb: Int, date: String, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Alamofire.request(Router.getNewsWithDate(group, nb, date))
            .validate()
            .responseArray { (alamoResponse: DataResponse<[News]>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func postSubscribeNotification(service: String, registration_id: String, host: String, newsgroup: String, completed: @escaping ((_ response:NotificationSub?, _ error:Error?) -> Void)) -> Void {
        
        let parameters: Parameters = [
            "service": service,
            "registration_id": registration_id,
            "host": host,
            "newsgroup": newsgroup
        ]
        
        Alamofire.request(Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_SUB, method: .post, parameters: parameters, headers: Constants.Headers.headers)
            .validate()
            .responseObject { (alamoResponse: DataResponse<NotificationSub>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func postUnsubscribeNotification(service: String, registration_id: String, host: String, newsgroup: String, completed: @escaping ((_ response:NotificationUnsub?, _ error:Error?) -> Void)) -> Void {
        
        let parameters: Parameters = [
            "service": service,
            "registration_id": registration_id,
            "host": host,
            "newsgroup": newsgroup
        ]
        
        Alamofire.request(Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_UNSUB, method: .post, parameters: parameters, headers: Constants.Headers.headers)
            .validate()
            .responseObject { (alamoResponse: DataResponse<NotificationUnsub>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }

    static func postSubscribedGroups(service: String, registration_id: String, host: String, completed: @escaping ((_ response: NotificationGroups?, _ error:Error?) -> Void)) -> Void {
        let parameters: Parameters = [
            "service": service,
            "registration_id": registration_id,
            "host": host
        ]
        Alamofire.request(Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_GROUPS, method: .post, parameters: parameters, headers: Constants.Headers.headers)
        .validate()
        .responseObject { (alamoResponse: DataResponse<NotificationGroups>) in
            completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getSearch(term: String, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Alamofire.request(Router.getSearch(term))
            .validate()
            .responseArray { (alamoResponse: DataResponse<[News]>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getLastNews(nb: Int, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Alamofire.request(Router.getLastNews(nb))
            .validate()
            .responseArray { (alamoResponse: DataResponse<[News]>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
}

//
//  DataAccess.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation
import Alamofire

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
    case getStudent()
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
        case .getStudent:
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
        case .getStudent:
            return Constants.Hidden.STUDENTS_URL

        }
    }
    
    fileprivate var headers: HTTPHeaders {
        switch self {
        case .getStudent:
            return HTTPHeaders.init()
        default:
            return Constants.Headers.headers
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        var parameters: Parameters?
        
        switch self {
        case .postSubscribedGroups(let service, let registration_id, let host):
            parameters = [
                "service": service,
                "registration_id": registration_id,
                "host": host
            ]
        case .postSubscribeNotification(let service, let registration_id, let host, let newsgroup):
            parameters = [
                "service": service,
                "registration_id": registration_id,
                "host": host,
                "newsgroup": newsgroup
            ]
        case .postUnsubscribeNotification(let service, let registration_id, let host, let newsgroup):
            parameters = [
                "service": service,
                "registration_id": registration_id,
                "host": host,
                "newsgroup": newsgroup
            ]
        default:
            break
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
            }
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        }
        return request
    }
    
    
    func makeAlamofireRequest(completionHandler: @escaping (_ data: DataResponse<Data>?, _ error: Error?) -> ()) {
        if Reachability.isConnectedToNetwork() {
            Alamofire.request(self.urlRequest).validate().responseData { (response) in
                completionHandler(response, response.result.error)
            }
        }
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
        Router.getGroups().makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[Group]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func getTopics(id: Int, completed: @escaping ((_ response:Topic?, _ error:Error?) -> Void)) -> Void {
        Router.getTopics(id).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<Topic>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func getNews(group: String, nb: Int, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Router.getNews(group, nb).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[News]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func getNewsWithDate(group: String, nb: Int, date: String, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Router.getNewsWithDate(group, nb, date).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[News]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func postSubscribeNotification(service: String, registration_id: String, host: String, newsgroup: String, completed: @escaping ((_ response:NotificationSub?, _ error:Error?) -> Void)) -> Void {
//        Router.postSubscribeNotification(service, registration_id, host, newsgroup).makeAlamofireRequest { (response, error) in
//            if error == nil {
//                DecoderJSON<NotificationSub>().decode(response: response, completed: { (response, error) in
//                    completed(response, error)
//                })
//            }
//        }
        
        
        let parameters: Parameters = [
            "service": service,
            "registration_id": registration_id,
            "host": host,
            "newsgroup": newsgroup
        ]


        Alamofire.request(Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_SUB, method: .post, parameters: parameters, headers: Constants.Headers.headers).responseData { (response) in
                DecoderJSON<NotificationSub>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
    }
    
    static func postUnsubscribeNotification(service: String, registration_id: String, host: String, newsgroup: String, completed: @escaping ((_ response:NotificationUnsub?, _ error:Error?) -> Void)) -> Void {
        
//        Router.postUnsubscribeNotification(service, registration_id, host, newsgroup).makeAlamofireRequest { (response, error) in
//            if error == nil {
//                DecoderJSON<NotificationUnsub>().decode(response: response, completed: { (response, error) in
//                    completed(response, error)
//                })
//            }
//        }
        
        
        let parameters: Parameters = [
            "service": service,
            "registration_id": registration_id,
            "host": host,
            "newsgroup": newsgroup
        ]
        
        
        Alamofire.request(Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_UNSUB, method: .post, parameters: parameters, headers: Constants.Headers.headers).responseData { (response) in
            DecoderJSON<NotificationUnsub>().decode(response: response, completed: { (response, error) in
                completed(response, error)
            })
        }
    }

    static func postSubscribedGroups(service: String, registration_id: String, host: String, completed: @escaping ((_ response: NotificationGroups?, _ error:Error?) -> Void)) -> Void {
        
//        Router.postSubscribedGroups(service, registration_id, host).makeAlamofireRequest { (response, error) in
//            if error == nil {
//                DecoderJSON<NotificationGroups>().decode(response: response, completed: { (response, error) in
//                    completed(response, error)
//                })
//            }
//        }
        
        let parameters: Parameters = [
            "service": service,
            "registration_id": registration_id,
            "host": host
        ]
        
        Alamofire.request(Constants.Url.ENTRY_API_URL + Constants.Url.NOTIF_GROUPS, method: .post, parameters: parameters, headers: Constants.Headers.headers).responseData { (response) in
            DecoderJSON<NotificationGroups>().decode(response: response, completed: { (response, error) in
                completed(response, error)
            })
        }
    }
    
    static func getSearch(term: String, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        
        Router.getSearch(term).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[News]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func getLastNews(nb: Int, completed: @escaping ((_ response:[News]?, _ error:Error?) -> Void)) -> Void {
        Router.getLastNews(nb).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[News]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    
    static func getStudent(completed: @escaping ((_ response:[Student]?, _ error:Error?) -> Void)) -> Void {
        if Constants.Hidden.STUDENTS_URL != "" {
            Router.getStudent().makeAlamofireRequest { (response, error) in
                if error == nil {
                    DecoderJSON<[Student]>().decode(response: response, completed: { (response, error) in
                        completed(response, error)
                    })
                }
            }
        }
    }
}


class DecoderJSON<T: Codable> {
    func decode(data: Data?, response: URLResponse?, error: Error?, completed: (T?, Error?) -> ()) {
        do {
            let decoder = JSONDecoder()
            print(String(data: data!, encoding: .utf8) ?? "")
            let dataRes = try decoder.decode(T.self, from: data!)
            completed(dataRes, error)
        }
        catch let error {
            completed(nil, error)
        }
    }
    
    func decode(data: [String: Any], completed: (T?, Error?) -> ()) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let decoder = JSONDecoder()
            let dataRes = try decoder.decode(T.self, from: data!)
            completed(dataRes, nil)
        }
        catch let error {
            completed(nil, error)
        }
    }
    
    func decode(response: DataResponse<Data>?, completed: (T?, Error?) -> ()) {
        do {
            let decoder = JSONDecoder()
            let dataRes = try decoder.decode(T.self, from: (response?.data!)!)
            completed(dataRes, nil)
        }
        catch let error {
            completed(nil, error)
        }
    }
    
    func encode(data: T) -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return dictionary
        }
        catch _ {
            return nil
        }
    }
    
    func toString(data: T) -> String {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            return String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
        }
        catch _ {
            return ""
        }
    }
}

extension Encodable {
    func toJSONString() -> String? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        }
        catch _ {
            return nil
        }
    }
    
    func toJSON() -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return dictionary
        }
        catch _ {
            return nil
        }
    }
}

public struct Safe<Base: Codable>: Codable {
    public let value: Base?
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            assertionFailure("ERROR: \(error)")
            self.value = nil
        }
    }
}


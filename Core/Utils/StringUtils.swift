//
//  StringUtils.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 21/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

public func parseAuthor(_ authorStr: String) -> [String] {
    var author = ""
    var mail = ""
    var inMail = false
    for i in authorStr {
        if inMail == false {
            if i == "<" {
                inMail = true
            }
            else {
                author.append(i)
            }
        }
        else {
            if i == ">" {
                inMail = true
            }
            else {
                mail.append(i)
            }
        }
    }
    return [author, mail]
}

public func parseLogin(_ mailStr: String) -> String {
    var login = ""
    for i in mailStr {
        if i == "@" {
            return login
        }
        else {
            login.append(i)
        }
    }
    return login
}

public func parseLoginFromSubject(_ subjectStr: String) -> String {
    let parsedSubject = parseSubject(subjectStr)
    if parsedSubject.first == "Re: " || parsedSubject.first == "Re:" {
        return ""
    }
    let sub = parsedSubject.last
    let splitted = sub?.components(separatedBy: " ")
    for i in splitted! {
        if i != "" {
            return i
        }
    }
    return ""
}

public func appVersionValue() -> String {
    guard let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
        return ""
    }
    let vers = "Version \(version)"
    return vers
}

public func getProfilePic(mail: String, subject: String) -> URL? {
    let login1 = parseLogin(mail)
    let login2 = parseLoginFromSubject(subject)
    
    var url = "https://photos.cri.epita.net/"
    
    if login1 == login2 {
        url += login1
    }
    else if login2.contains("_") {
        url += login2
    }
    else {
        url += login1
    }
    url += "-thumb"
    return URL(string: url)
}

public func parseSubject(_ subjectStr: String) -> [String] {
    var subs = [String]()
    var tmp = ""
    var isInCroch = false
    for i in subjectStr {
        if isInCroch == false {
            if i == "[" {
                if tmp != "" {
                    subs.append(tmp)
                    tmp = ""
                }
                isInCroch = true
            }
            else {
                tmp.append(i)
            }
        }
        else {
            if i == "]" {
                subs.append(tmp)
                tmp = ""
                isInCroch = false
            }
            else {
                tmp.append(i)
            }
        }
    }
    subs.append(tmp)
    return subs
}

func parse(subjectStr: String) -> ([String], String) {
    
    var sub = ""
    var tags = [String]()
    var tmp = ""
    var isInCroch = false
    for i in subjectStr {
        if isInCroch == false {
            if i == "[" {
                if tmp != "" {
                    sub += tmp
                    tmp = ""
                }
                isInCroch = true
            }
            else {
                sub.append(i)
            }
        }
        else {
            if i == "]" {
                tags.append(tmp)
                tmp = ""
                isInCroch = false
            }
            else {
                tmp.append(i)
            }
        }
    }
    return (tags, sub)
}

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }
    
    func addZero() -> String {
        if self.count == 0 {
            return "00"
        }
        else if self.count == 1 {
            return "0\(self)"
        }
        else {
            return self
        }
    }
    
    func sha256() -> String {
        if self != "" {
            if let data = self.data(using: .utf8) {
                var digest = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
                let _ = digest.withUnsafeMutableBytes { bytes in
                    data.withUnsafeBytes { messageBytes in
                        CC_SHA256(messageBytes, CC_LONG(data.count), bytes)
                    }
                }
                return digest.map { String(format: "%02hhx", $0) }.joined()
            }
        }
        return ""
    }
}

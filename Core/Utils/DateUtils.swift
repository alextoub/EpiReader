//
//  DateUtils.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

/**
 Generate a Date Object from a string
 - parameter dateStr: String to convert (ex: 2017-03-10T10:03:00Z)
 - returns: Date Object
 */
public func StrToDate(dateStr: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return dateFormatter.date(from: dateStr)!
}

/**
 Generate a String of form Friday 10 March from a string
 - parameter dateStr: String to convert (ex: 2017-03-10T10:03:00Z)
 - returns: String of type Friday 10 March
 */
public func StrToDay(dateStr: String) -> String {
    let date = StrToDate(dateStr: dateStr)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE d MMMM"
    return dateFormatter.string(from: date).capitalizingFirstLetter()
}

/**
 Generate a String of form Fri from a string
 - parameter dateStr: String to convert (ex: 2017-03-10T10:03:00Z)
 - returns: String of type Fri or Wed
 */
public func StrToEE(dateStr: String) -> String {
    let date = StrToDate(dateStr: dateStr)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "EE"
    return dateFormatter.string(from: date)
}

/**
 Generate a String of form 00:00\n02:00 from 2 strings
 - parameter dateBeginStr: String of the begin date of the event (ex: 2017-03-10T00:00:00Z)
 - parameter dateEndStr: String of the end date of the event (ex: 2017-03-10T02:00:00Z)
 - returns: String of type 00:00\n02:00
 */
public func StrToHour(dateBeginStr: String, dateEndStr: String) -> String {
    let dateBegin = StrToDate(dateStr: dateBeginStr)
    let dateEnd = StrToDate(dateStr: dateEndStr)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH':'mm"
    let dateStr = "\(dateFormatter.string(from: dateBegin))\n\(dateFormatter.string(from: dateEnd))"
    return dateStr
}

public func StrToAbrev(dateStr: String) -> String {
    let date = StrToDate(dateStr: dateStr)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    let dateStr = "\(dateFormatter.string(from: date))"
    return dateStr
}

public func StrToAbrevWithHour(dateStr: String) -> String {
    let date = StrToDate(dateStr: dateStr)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    let hourFormatter = DateFormatter()
    hourFormatter.dateFormat = "HH'h'mm"
    let dateStr = "\(dateFormatter.string(from: date)) à \(hourFormatter.string(from: date))"
    return dateStr
}

public func getYear(dateStr: String) -> Int?
{
    let date = StrToDate(dateStr: dateStr)
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return components.year
}

public func StrToInfo(dateStr: String) -> String {

    let nowDate = Date()
    let date = StrToDate(dateStr: dateStr)
    let interval = nowDate.timeIntervalSince(date)
    let curr = Calendar.current

    let minutes: Int = Int(interval / 60)

    if minutes >= 0 && minutes < 5 {
        return "À l'instant"
    }
    if minutes >= 5 && minutes < 60 {
        return "Il y a \(minutes) mns"
    }

    let date1 = curr.startOfDay(for: nowDate)
    let date2 = curr.startOfDay(for: date)

    let components = curr.dateComponents([.day], from: date1, to: date2)
    
    let hour = "\(curr.component(.hour, from: date))".addZero()
    let minute = "\(curr.component(.minute, from: date))".addZero()
    
    if components.day == 0 {
        
        return "\(hour):\(minute)"
    }
    if components.day == -1 {
        return "Hier, \(hour):\(minute)"
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    return "\(dateFormatter.string(from: date))."
}

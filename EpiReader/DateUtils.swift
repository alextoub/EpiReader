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
  dateFormatter.timeZone = TimeZone(abbreviation: "BST")
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

extension String {
  func capitalizingFirstLetter() -> String {
    let first = String(characters.prefix(1)).capitalized
    let other = String(characters.dropFirst())
    return first + other
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}

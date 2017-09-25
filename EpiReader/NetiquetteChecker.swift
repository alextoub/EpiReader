//
//  NetiquetteChecker.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/24/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class NetiquetteChecker {
    
    var error = [String]()
    var warning = [String]()
    
    func checkRegexSubject(subject: String) {
        let pattern = "(?:Re: ?)?\\[([+\\w\\/]+)\\]\\[([+\\w\\/]+)\\] (.*)"
        let regex = subject.matchingStrings(regex: pattern)
        if !regex.isEmpty {
            if regex.first!.count == 4 {
                let subject = regex.first![0]
                let firstTag = regex.first![1]
                let secondTag = regex.first![2]
                checkTag(tag: firstTag)
                checkTag(tag: secondTag)
                if subject.characters.count > 80 {
                    error.append("Subject should not exceed 80 columns.")
                }
            }
            else {
                error.append("Subject must contain two tags and a summary.")
            }
        }
        else {
            error.append("Subject must contain two tags and a summary.")
        }
    }
    
    func checkTag(tag: String) {
        if tag.uppercased() != tag {
            error.append("Tag \(tag) must be uppercase.")
        }
        if tag.characters.count > 10 {
            warning.append("Tag \(tag) should not exceed 10 letters.")
        }
    }
    
    func checkContentError(content: String) {
        var findSignature = false
        var findQuote = false
        let quoteRegex = "> (.*)"
        var currentlyInQuote = false
        var currentlyInSignature = false
        
        let lines = content.components(separatedBy: "\n")
        for index in 0..<lines.count {
            var prevLine = index - 1
            var line = lines[index]
            var length = line.characters.count
            if !currentlyInQuote && length > 72 && length < 80 {
                warning.append("L \(index) - Non quoted line should not exceed 72 columns: Line length is \(length).")
            }
            else if length > 80 {
                error.append("L \(index) - Line must not exceed 80 columns. : Line length is \(length).")
            }
            
            if line == "-- " {
                findSignature = true
                currentlyInSignature = true
                
                if index < lines.count - 5 {
                    error.append("L\(index) - Signature must not be longer than 4 lines: current is \(lines.count - index)")
                }
                if lines[prevLine].count > 0 {
                    error.append("L\(index) - Signature must be seperated by an empty line")
                }
            }
            else {
                if length != 0 && Array(line)[length - 1] == " " { //line.characters[length - 1] == " " {
                    error.append("L\(index) - Line must not have trailing whitespaces.")
                }
            }
            if !line.matchingStrings(regex: quoteRegex).isEmpty {
                if !currentlyInQuote {
                    var noHeader = false
                    if !findQuote && prevLine > 0 && lines[prevLine].count != 0 {
                        warning.append("L\(index) - Quote should be preceded by a header.")
                        noHeader = true
                    }
                    let emptyLine = prevLine - (findQuote ? 0 : 1)
                    if emptyLine < 0 {
                        error.append("L\(index) - The news must not begin by a quote.")
                    }
                    else if (!noHeader && lines[emptyLine].count != 0) {
                        error.append("L\(index) - Quote must be seperated by an empty line")
                    }
                }
                findQuote = true
                currentlyInQuote = true
            }
            else {
                if Array(line).first == ">" {
                    warning.append("L\(index) - Quote may be malformed")
                }
                else if currentlyInQuote {
                    if length != 0  {
                        error.append("L\(index) - Quote must be seperated by an empty line")
                    }
                    currentlyInQuote = false
                }
            }
        }
        if (!findSignature) {
            error.append("Content must contain a signature.")
        }
    }
    
    func checkNews(topic: Topic) -> ErrorNetiquette {
        checkRegexSubject(subject: topic.subject!)
        checkContentError(content: topic.content!)
        
        let errors = ErrorNetiquette(errors: error, warnings: warning)
        
        return errors
    }
}

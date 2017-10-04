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
                if subject.count > 80 {
                    error.append("Le sujet ne doit pas depasser 80 colonnes.")
                }
            }
            else {
                error.append("Le sujet doit contenir 2 balises et le sujet de la news.")
            }
        }
        else {
            error.append("Le sujet doit contenir 2 balises et le sujet de la news.")
        }
    }
    
    func checkTag(tag: String) {
        if tag.uppercased() != tag {
            error.append("La balise \(tag) doit être en majuscule.")
        }
        if tag.count > 10 {
            warning.append("La balise \(tag) ne doit pas dépasser 10 lettres.")
        }
    }
    
    func checkContentError(content: String) {
        var findSignature = false
        var findQuote = false
        let quoteRegex = "> (.*)"
        var currentlyInQuote = false
        
        let lines = content.components(separatedBy: "\n")
        for index in 0..<lines.count {
            let prevLine = index - 1
            let line = lines[index]
            let length = line.count
            if !currentlyInQuote && length > 72 && length < 80 {
                warning.append("L \(index) - Les lignes qui ne sont pas des citations ne doivent pas dépasser 72 colonnes: La ligne fait \(length) colonnes.")
            }
            else if length > 80 {
                error.append("L \(index) - La ligne ne doit pas dépasser 80 colonnes. : La ligne fait \(length) colonnes.")
            }
            
            if line == "-- " {
                findSignature = true
                
                if index < lines.count - 5 {
                    error.append("L\(index) - La signature ne doit pas depasser 4 lignes: \(lines.count - index) lignes actuellement.")
                }
                if lines[prevLine].count > 0 {
                    error.append("L\(index) - La signature doit être sparé par une ligne vide.")
                }
            }
            else {
                if length != 0 && Array(line)[length - 1] == " " { //line.characters[length - 1] == " " {
                    error.append("L\(index) - La ligne ne doit pas avoir des espaces vides.")
                }
            }
            if !line.matchingStrings(regex: quoteRegex).isEmpty {
                if !currentlyInQuote {
                    var noHeader = false
                    if !findQuote && prevLine > 0 && lines[prevLine].count != 0 {
                        warning.append("L\(index) - La citation doit être précédée d'un en-tête.")
                        noHeader = true
                    }
                    let emptyLine = prevLine - (findQuote ? 0 : 1)
                    if emptyLine < 0 {
                        error.append("L\(index) - Les news ne doivent pas commencer par une citation.")
                    }
                    else if (!noHeader && lines[emptyLine].count != 0) {
                        error.append("L\(index) - La citation doit être séparée par une ligne vide.")
                    }
                }
                findQuote = true
                currentlyInQuote = true
            }
            else {
                if Array(line).first == ">" {
                    warning.append("L\(index) - La citation doit être mal formée.")
                }
                else if currentlyInQuote {
                    if length != 0  {
                        error.append("L\(index) - La citation doit être séparée par une ligne vide.")
                    }
                    currentlyInQuote = false
                }
            }
        }
        if (!findSignature) {
            error.append("La news doit contenir une signature.")
        }
    }
    
    func checkNews(topic: Topic) -> ErrorNetiquette {
        checkRegexSubject(subject: topic.subject!)
        checkContentError(content: topic.content!)
        
        let errors = ErrorNetiquette(errors: error, warnings: warning)
        
        return errors
    }
}

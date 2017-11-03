//
//  PGPParser.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 02/11/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class PGPParser {
    
    var utf8Array = ["=C2=A1": "¡","=C2=A2": "¢","=C2=A3": "£","=C2=A4": "¤","=C2=A5": "¥","=C2=A6": "¦","=C2=A7": "§","=C2=A8": "¨"
        ,"=C2=A9": "©","=C2=AA": "ª","=C2=AB": "«","=C2=AC": "¬","=C2=AE": "®","=C2=AF": "¯","=C2=B0": "°","=C2=B1": "±"
        ,"=C2=B2": "²","=C2=B3": "³","=C2=B4": "´","=C2=B5": "µ","=C2=B6": "¶","=C2=B7": "·","=C2=B8": "¸","=C2=B9": "¹"
        ,"=C2=BA": "º","=C2=BB": "»","=C2=BC": "¼","=C2=BD": "½","=C2=BE": "¾","=C2=BF": "¿","=C3=80": "À","=C3=81": "Á"
        ,"=C3=82": "Â","=C3=83": "Ã","=C3=84": "Ä","=C3=85": "Å","=C3=86": "Æ","=C3=87": "Ç","=C3=88": "È","=C3=89": "É"
        ,"=C3=8A": "Ê","=C3=8B": "Ë","=C3=8C": "Ì","=C3=8D": "Í","=C3=8E": "Î","=C3=8F": "Ï","=C3=90": "Ð","=C3=91": "Ñ"
        ,"=C3=92": "Ò","=C3=93": "Ó","=C3=94": "Ô","=C3=95": "Õ","=C3=96": "Ö","=C3=97": "×","=C3=98": "Ø","=C3=99": "Ù"
        ,"=C3=9A": "Ú","=C3=9B": "Û","=C3=9C": "Ü","=C3=9D": "Ý","=C3=9E": "Þ","=C3=9F": "ß","=C3=A0": "à","=C3=A1": "á"
        ,"=C3=A2": "â","=C3=A3": "ã","=C3=A4": "ä","=C3=A5": "å","=C3=A6": "æ","=C3=A7": "ç","=C3=A8": "è","=C3=A9": "é"
        ,"=C3=AA": "ê","=C3=AB": "ë","=C3=AC": "ì","=C3=AD": "í","=C3=AE": "î","=C3=AF": "ï","=C3=B0": "ð","=C3=B1": "ñ"
        ,"=C3=B2": "ò","=C3=B3": "ó","=C3=B4": "ô","=C3=B5": "õ","=C3=B6": "ö","=C3=B7": "÷","=C3=B8": "ø","=C3=B9": "ù"
        ,"=C3=BA": "ú","=C3=BB": "û","=C3=BC": "ü","=C3=BD": "ý","=C3=BE": "þ","=C3=BF": "ÿ", "=20": " ", "=C2=A0": ""
        , "=\n": "", "quoted-printable": ""]
    
    func isPgp(content: String) -> Bool  {
        if content.contains("This is an OpenPGP/MIME signed message") {
            return true
        }
        return false
    }
    
    func getBoundaryKey(content: String) -> String {
        let boundary = slice(content: content, from: "boundary=\"", to: "\"")
        return boundary!
    }
    
    func slice(content: String, from: String, to: String) -> String? {
        return (content.range(of: from)?.upperBound).flatMap { substringFrom in
            (content.range(of: to, range: substringFrom..<content.endIndex)?.lowerBound).map { substringTo in
                String(content[substringFrom..<substringTo])
            }
        }
    }
    
    func getRealText(content: String) -> String {
        var tmp = content
        for element in utf8Array {
            tmp = tmp.replacingOccurrences(of: element.key, with: element.value)
        }
        return tmp
    }
    
    func parsePGP(content: String) -> String {
        let body = content
        if isPgp(content: content) {
            if let text = slice(content: content, from: "Content-Transfer-Encoding: ", to: "--\(getBoundaryKey(content: content))") {
                var real = getRealText(content: text)
                while real.hasPrefix("\n") {
                    real.remove(at: real.startIndex)
                }
                return real
            }
        }
        return body
    }
}

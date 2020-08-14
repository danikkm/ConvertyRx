//
//  Converter.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

enum Base: String {
    case binary = "2"
    case octal = "8"
    case decimal = "10"
    case hex = "16"
}

enum RegexBase: String {
    case binary = "0-1"
    case octal = "0-7"
    case decimal = "0-9"
    case hex = "0-9A-F"
}

enum Conversion {
    static let hexTable = [
        "0/hex": "0",
        "1/hex": "1",
        "2/hex": "2",
        "3/hex": "3",
        "4/hex": "4",
        "5/hex": "5",
        "6/hex": "6",
        "7/hex": "7",
        "8/hex": "8",
        "9/hex": "9",
        "10/hex": "A",
        "11/hex": "B",
        "12/hex": "C",
        "13/hex": "D",
        "14/hex": "E",
        "15/hex": "F",
    ]
    static let precision = 12
}

protocol ConversionProtocol {
    func splitStr(text: String, length: Int) -> [Substring]
    func convertBase(fromBase base: Base, number: String, toBase: Base) -> (getString: String?, getDouble: Double?)
    func validInput(inputNumber: String, inputBase: RegexBase) -> Bool
}

public class Converter: ConversionProtocol {
    func splitStr(text: String, length: Int) -> [Substring] {
        return stride(from: 0, to: text.count, by: length)
            .map { text[text.index(text.startIndex, offsetBy: $0)..<text.index(text.startIndex, offsetBy: min($0 + length, text.count))] }
    }
    
    func convertBase(fromBase base: Base, number: String, toBase: Base) -> (getString: String?, getDouble: Double?) {
        guard let decimalNumber = UInt64(number, radix: Int(base.rawValue)!) else { return ("", nil) }
        
        switch toBase {
            case .binary:
                return (String(decimalNumber, radix: Int(toBase.rawValue)!, uppercase: true), nil)
            case .octal:
                return (String(decimalNumber, radix: Int(toBase.rawValue)!, uppercase: true), nil)
            case .decimal:
                return ("", Double(decimalNumber))
            case .hex:
                return (String(decimalNumber, radix: Int(toBase.rawValue)!, uppercase: true), nil)
        }
    }
    
    func validInput(inputNumber: String, inputBase: RegexBase) -> Bool {
        if inputNumber.components(separatedBy: ".").count - 1 <= 1 {
            return true
        }
        if inputNumber.range(of: "^(?=.)([+-]?([\(inputBase.rawValue)]*)(\\.([\(inputBase.rawValue)]+))?)$", options: .regularExpression) != nil {
            return true
        }
        return false
    }
}

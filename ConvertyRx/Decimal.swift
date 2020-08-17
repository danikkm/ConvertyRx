//
//  Decimal.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Decimal: BaseDecimalConverterProtocol {
    func decimalToBinaryFractional(inputDecimal: String) -> String {
        if Converter().validInput(inputNumber: inputDecimal, inputBase: .decimal) {
            guard let decimal = Double(inputDecimal) else { return "" }
            
            var (binaryDigit, fractionalPart) = (0, decimal.truncatingRemainder(dividingBy: 1))
            var result = ""
            if !(floor(decimal) == decimal) {
                for _ in 0...Conversion.precision {
                    fractionalPart *= 2
                    binaryDigit = Int(floor(fractionalPart))
                    fractionalPart = fractionalPart.truncatingRemainder(dividingBy: 1)
                    result.append(String(binaryDigit))
                }
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: .binary).getString ?? "") + "." + result
            } else {
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: .binary).getString ?? "")
            }
        }
        return ""
    }
    
    func decimalToOctalFractional(inputDecimal: String) -> String {
        if Converter().validInput(inputNumber: inputDecimal, inputBase: .decimal) {
            guard let decimal = Double(inputDecimal) else { return "" }
            
            var (integer, fractionalPart) = (0, decimal.truncatingRemainder(dividingBy: 1))
            var result = ""
            if !(floor(decimal) == decimal) {
                for _ in 0...Conversion.precision {
                    fractionalPart *= 8
                    integer = Int(floor(fractionalPart))
                    fractionalPart = fractionalPart.truncatingRemainder(dividingBy: 1)
                    result.append(String(integer))
                }
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: .octal).getString ?? "") + "." + result
            } else {
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: .octal).getString ?? "")
            }
        }
        return ""
    }
    
    func decimalToHexFractional(inputDecimal: String) -> String {
        if Converter().validInput(inputNumber: inputDecimal, inputBase: .decimal) {
            guard let decimal = Double(inputDecimal) else { return "" }
            
            var (integer, fractionalPart) = (0, decimal.truncatingRemainder(dividingBy: 1))
            var result: [String] = []
            
            if !(floor(decimal) == decimal) {
                for _ in 0...Conversion.precision {
                    fractionalPart *= 16
                    integer = Int(floor(fractionalPart))
                    fractionalPart = fractionalPart.truncatingRemainder(dividingBy: 1)
                    result.append(contentsOf: [String(integer) + "/hex"])
                }
                var hexString = ""
                for item in result {
                    for (k, v) in Conversion.hexTable {
                        if item == k {
                            hexString.append(v)
                        }
                    }
                }
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: .hex).getString ?? "") + "." + hexString
            } else {
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: .hex).getString ?? "")
            }
        }
        return ""
    }
}

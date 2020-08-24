//
//  Decimal.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Decimal: BaseDecimalConverterProtocol {
    func convertToDecimalFractional(fromBase base: Base, regexBase: RegexBase, number: String) -> String {
        if Converter().validInput(inputNumber: number, inputBase: regexBase) {
            if number.contains(".") {
                if let range = number.range(of: ".") {
                    let fractionalPart = String(number[range.upperBound...])
                    let integerPart = String(number[..<range.lowerBound])
                    var decimals: [Double] = []
                    
                    if base == .hex {
                        decimals = Converter().convertHexFractionToDecimalFraction(fraction: fractionalPart)
                    } else {
                        decimals = fractionalPart.map { Double(String($0))! }
                    }
                    
                    var (fraction, power) = (0.0, 1.0)
                    
                    if let base = Double(base.rawValue) {
                        for number in decimals {
                            fraction += number * (1 / pow(base, power))
                            power += 1
                        }
                    }
                    
                    let convertedIntegerPart = Converter().convertBase(fromBase: base, number: integerPart, toBase: .decimal).getDouble ?? 0.0
                    
                    return String(convertedIntegerPart + fraction).removeTrailingZeros
                }
            } else  {
                return String(Converter().convertBase(fromBase: base, number: number, toBase: .decimal).getDouble ?? 0.0)
            }
        }
        return ""
    }
    
    func convertFromDecimalFractional(toBase base: Base, number: String) -> String {
        if Converter().validInput(inputNumber: number, inputBase: .decimal) {
            guard let decimal = Double(number) else { return "" }
            
            var (integer, fraction) = (0, decimal.truncatingRemainder(dividingBy: 1))
            
            if !(floor(decimal) == decimal) {
                var convertedNumber = Converter().convertDecimalToFraction(integer: &integer, fraction: &fraction, toBase: base)
                
                if base == .hex {
                    convertedNumber = Converter().mapHexTable(hex: &convertedNumber)
                }
                
                let convertedIntegerPart = Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: base).getString ?? ""
                
                return convertedIntegerPart + "." + convertedNumber.removeTrailingZeros
            } else {
                return String(Converter().convertBase(fromBase: .decimal, number: String(Int(decimal)), toBase: base).getString ?? "")
            }
        }
        return ""
    }
    
    
}

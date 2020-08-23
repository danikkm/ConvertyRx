//
//  Hex.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Hex: BaseHexConverterProtocol {
    func hexToBinaryFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            if hex.contains(".") {
                if let range = hex.range(of: ".") {
                    let fractionalPart = hex[range.upperBound...]
                    let integerPart = hex[..<range.lowerBound]

                    let convertedIntegerPart = Converter().convertBase(fromBase: .hex, number: String(integerPart), toBase: .binary).getString ?? ""
                    let convertedFractionalPart = Converter().convertBase(fromBase: .hex, number: String(fractionalPart), toBase: .binary).getString ?? ""
                                    
                    return convertedIntegerPart + "." + convertedFractionalPart
                }
            } else {
                return Converter().convertBase(fromBase: .hex, number: hex, toBase: .binary).getString ?? ""
            }
        }
        return ""
    }

    func hexToOctalFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            if hex.contains(".") {
                return Decimal().convertFromDecimalFractional(toBase: .octal, number: Decimal().convertToDecimalFractional(fromBase: .hex, regexBase: .hex, number: hex)).removeTrailingZeros
            } else {
                return Converter().convertBase(fromBase: .hex, number: hex, toBase: .octal).getString ?? ""
            }
        }
        return ""
    }

}

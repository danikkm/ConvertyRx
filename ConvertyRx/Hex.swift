//
//  Hex.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Hex: BaseHexConverterProtocol {
    func hexToBinaryFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            if hex.contains(".") {
                if let range = hex.range(of: ".") {
                    let fractional = hex[range.upperBound...]
                    let integerPart = hex[..<range.lowerBound]

                    return (Converter().convertBase(fromBase: .hex, number: String(integerPart), toBase: .binary).getString ?? "") + "." + (Converter().convertBase(fromBase: .hex, number: String(fractional), toBase: .binary).getString ?? "")

                }
            } else {
                return Converter().convertBase(fromBase: .hex, number: String(hex), toBase: .binary).getString ?? ""
            }
        }
        return ""
    }

    func hexToOctalFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            if hex.contains(".") {
                if let range = hex.range(of: ".") {
                    let fractional = hex[range.upperBound...]
                    let integerPart = hex[..<range.lowerBound]

                    return (Converter().convertBase(fromBase: .hex, number: String(integerPart), toBase: .octal).getString ?? "") + "." + (Converter().convertBase(fromBase: .hex, number: String(fractional), toBase: .octal).getString ?? "")

                }
            } else {
                return Converter().convertBase(fromBase: .hex, number: String(hex), toBase: .octal).getString ?? ""
            }
        }
        return ""
    }

    func hexToDecimalFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            var decimals: [String] = []
            var mappedDecimals: [Double] = []

            if hex.contains(".") {
                if let range = hex.range(of: ".") {
                    let fractional = hex[range.upperBound...]
                    let integerPart = hex[..<range.lowerBound]
                    var (fraction, power) = (0.0, 1.0)
                    
                    for letter in fractional {
                        for (k, v) in Conversion.hexTable {
                            if String(letter).uppercased() == v {
                                decimals.append(contentsOf: [k.replacingOccurrences(of: "\\/hex+.?", with: "", options: .regularExpression)])
                            }
                        }
                    }
                    
                    mappedDecimals = decimals.map { Double($0)! }

                    for number in mappedDecimals {
                        fraction += number * (1 / pow(16.0, power))
                        power += 1
                    }
                    return String((Converter().convertBase(fromBase: .hex, number: String(integerPart), toBase: .decimal).getDouble ?? 0.0) + fraction)
                }
            } else {
                return String(Converter().convertBase(fromBase: .hex, number: String(hex), toBase: .decimal, isDouble: false).getString ?? "")
            }
        }
        return ""
    }
}

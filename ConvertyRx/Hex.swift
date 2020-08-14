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
                    let mainPart = hex[..<range.lowerBound]

                    return (Converter().convertBase(fromBase: .hex, number: String(mainPart), toBase: .binary).getString ?? "") + "." + (Converter().convertBase(fromBase: .hex, number: String(fractional), toBase: .binary).getString ?? "")

                }
            } else {
                return Converter().convertBase(fromBase: .hex, number: String(hex), toBase: .binary).getString ?? ""
            }
        }
        return "Invalid input"
    }

    func hexToOctalFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            if hex.contains(".") {
                if let range = hex.range(of: ".") {
                    let fractional = hex[range.upperBound...]
                    let mainPart = hex[..<range.lowerBound]

                    return (Converter().convertBase(fromBase: .hex, number: String(mainPart), toBase: .octal).getString ?? "") + "." + (Converter().convertBase(fromBase: .hex, number: String(fractional), toBase: .octal).getString ?? "")

                }
            } else {
                return Converter().convertBase(fromBase: .hex, number: String(hex), toBase: .octal).getString ?? ""
            }
        }
        return "Invalid input"
    }

    func hexToDecimalFractional(hex: String) -> String {
        if Converter().validInput(inputNumber: hex, inputBase: .hex) {
            var result: [String] = []
            var decimals: [Double] = []

            if hex.contains(".") {
                if let range = hex.range(of: ".") {
                    let fractional = hex[range.upperBound...]
                    let mainPart = hex[..<range.lowerBound]
                    for letter in fractional {
                        for (k, v) in Conversion.hexTable {
                            if String(letter).uppercased() == v {
                                result.append(contentsOf: [k.replacingOccurrences(of: "\\/hex+.?", with: "", options: .regularExpression)])
                            }
                        }
                    }

                    decimals = result.map { Double($0)! }
                    var (fraction, power) = (0.0, 1.0)

                    for number in decimals {
                        fraction += number * (1 / pow(16.0, power))
                        power += 1
                    }

                    return String((Converter().convertBase(fromBase: .hex, number: String(mainPart), toBase: .decimal).getDouble ?? 0.0) + fraction)
                }
            } else {
                return String(Converter().convertBase(fromBase: .hex, number: String(hex), toBase: .decimal).getDouble ?? 0.0)
            }
        }
        return "Invalid input"
    }
}

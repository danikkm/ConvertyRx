//
//  Binary.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-12.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Binary: BaseBinaryConverterProtocol {
    func binaryToOctalFractional(binary: String) -> String {
        if Converter().validInput(inputNumber: binary, inputBase: .binary) {
            if binary.contains(".") {
                if let range = binary.range(of: ".") {
                    let fractional = binary[range.upperBound...]
                    var fractionalSplit = Converter().splitStr(text: String(fractional), length: 3)
                    let mainPart = binary[..<range.lowerBound]

                    for (i, fraction) in fractionalSplit.enumerated() {
                        if fraction.count % 2 != 0 {
                            while fractionalSplit[i].count != 3 {
                                fractionalSplit[i].insert("0", at: fractionalSplit[i].endIndex)

                            }
                        } else {
                            while fractionalSplit[i].count != 3 {
                                fractionalSplit[i].insert("0", at: fractionalSplit[i].endIndex)
                            }
                        }
                    }

                    let pFractional = fractionalSplit.joined(separator: "")
                    return (Converter().convertBase(fromBase: .binary, number: String(mainPart), toBase: .octal).getString ?? "") +
                        "." + (Converter().convertBase(fromBase: .binary, number: String(pFractional), toBase: .octal).getString ?? "")
                }
            } else {
                return Converter().convertBase(fromBase: .binary, number: String(binary), toBase: .octal).getString ?? ""
            }
        }
        return "Invalid input"
    }

    func binaryToDecimalFractional(binary: String) -> String {
        if Converter().validInput(inputNumber: binary, inputBase: .binary) {
            if binary.contains(".") {
                if let range = binary.range(of: ".") {
                    let fractional = binary[range.upperBound...]
                    let mainPart = binary[..<range.lowerBound]
                    var (baseDecimalFraction, decimalFraction) = (1.0, 0.0)
                    for fraction in fractional {
                        switch fraction {
                        case "0":
                            baseDecimalFraction /= 2.0
                        case "1":
                            baseDecimalFraction /= 2.0
                            decimalFraction += baseDecimalFraction

                        default:
                            return "Error"
                        }
                    }
                    return String((Converter().convertBase(fromBase: .binary, number: String(mainPart), toBase: .decimal).getDouble ?? 0.0) + decimalFraction)
                }
            } else {
                return String(Converter().convertBase(fromBase: .binary, number: String(binary), toBase: .decimal).getDouble ?? 0.0)
            }
        }
        return "Invalid input"
    }

    func binaryToHexFractional(binary: String) -> String {
        if Converter().validInput(inputNumber: binary, inputBase: .binary) {
            if binary.contains(".") {
                if let range = binary.range(of: ".") {
                    let fractional = binary[range.upperBound...]
                    var fractionalSplit = Converter().splitStr(text: String(fractional), length: 4)
                    let mainPart = binary[..<range.lowerBound]

                    for (i, fraction) in fractionalSplit.enumerated() {
                        if fraction.count % 2 != 0 {
                            while fractionalSplit[i].count != 4 {
                                fractionalSplit[i].insert("0", at: fractionalSplit[i].endIndex)

                            }
                        } else {
                            while fractionalSplit[i].count != 4 {
                                fractionalSplit[i].insert("0", at: fractionalSplit[i].endIndex)
                            }
                        }
                    }

                    let pFractional = fractionalSplit.joined(separator: "")
                    return (Converter().convertBase(fromBase: .binary, number: String(mainPart), toBase: .hex).getString ?? "") + "." + (Converter().convertBase(fromBase: .binary, number: String(pFractional), toBase: .hex).getString ?? "")
                }
            } else {
                return Converter().convertBase(fromBase: .binary, number: String(binary), toBase: .hex).getString ?? ""
            }
        }
        return "Invalid input"
    }

}

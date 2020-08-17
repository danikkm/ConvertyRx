//
//  Octal.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Octal: BaseOctalConverterProtocol {
    func octalToBinaryFractional(octal: String) -> String {
        if Converter().validInput(inputNumber: octal, inputBase: .octal) {
            if octal.contains(".") {
                if let range = octal.range(of: ".") {
                    let fractional = octal[range.upperBound...]
                    let mainPart = octal[..<range.lowerBound]

                    return (Converter().convertBase(fromBase: .octal, number: String(mainPart), toBase: .binary).getString ?? "") + "." + (Converter().convertBase(fromBase: .octal, number: String(fractional), toBase: .binary).getString ?? "")
                }
            } else {
                return Converter().convertBase(fromBase: .octal, number: String(octal), toBase: .binary).getString ?? ""
            }
        }
        return ""
    }

    func octalToDecimalFractional(octal: String) -> String {
        if Converter().validInput(inputNumber: octal, inputBase: .octal) {
            var decimals: [Double] = []

            if octal.contains(".") {
                if let range = octal.range(of: ".") {
                    let fractional = octal[range.upperBound...]
                    let mainPart = octal[..<range.lowerBound]

                    decimals = fractional.map { Double(String($0))! }

                    var (fraction, power) = (0.0, 1.0)

                    for number in decimals {
                        fraction += number * (1 / pow(8.0, power))
                        power += 1
                    }

                    return String((Converter().convertBase(fromBase: .octal, number: String(mainPart), toBase: .decimal).getDouble ?? 0.0) + fraction)
                }
            } else {
                return String(Converter().convertBase(fromBase: .octal, number: String(octal), toBase: .decimal, isDouble: false).getString ?? "")
            }
        }
        return ""
    }

    func octalToHexFractional(octal: String) -> String {
        if Converter().validInput(inputNumber: octal, inputBase: .octal) {
            if octal.contains(".") {
                return Binary().binaryToHexFractional(binary: octalToBinaryFractional(octal: octal))
            } else {
                return Converter().convertBase(fromBase: .octal, number: String(octal), toBase: .hex).getString ?? ""
            }
        }
        return ""
    }
}

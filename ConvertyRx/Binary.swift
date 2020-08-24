//
//  Binary.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-12.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Binary: BaseBinaryConverterProtocol {
    func binaryToOctalFractional(binary: String) -> String {
        if Converter().validInput(inputNumber: binary, inputBase: .binary) {
            if binary.contains(".") {
                if let range = binary.range(of: ".") {
                    let fractionalPart = binary[range.upperBound...]
                    var fractionalSplit = Converter().splitStr(text: String(fractionalPart), length: 3)
                    let integerPart = binary[..<range.lowerBound]

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
                    print(fractionalSplit)
                    let joinedFractional = fractionalSplit.joined(separator: "")
                    let convertedIntegerPart = Converter().convertBase(fromBase: .binary, number: String(integerPart), toBase: .octal).getString ?? ""
                    let convertedFractionalPart = Converter().convertBase(fromBase: .binary, number: String(joinedFractional), toBase: .octal).getString ?? ""
                    
                    return convertedIntegerPart + "." + convertedFractionalPart
                }
            } else {
                return Converter().convertBase(fromBase: .binary, number: String(binary), toBase: .octal).getString ?? ""
            }
        }
        return ""
    }

    func binaryToHexFractional(binary: String) -> String {
        if Converter().validInput(inputNumber: binary, inputBase: .binary) {
            if binary.contains(".") {
                if let range = binary.range(of: ".") {
                    let fractionalPart = binary[range.upperBound...]
                    var fractionalSplit = Converter().splitStr(text: String(fractionalPart), length: 4)
                    let integerPart = binary[..<range.lowerBound]

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

                    let joinedFractional = fractionalSplit.joined(separator: "")
                    let convertedIntegerPart = Converter().convertBase(fromBase: .binary, number: String(integerPart), toBase: .hex).getString ?? ""
                    let convertedFractionalPart = Converter().convertBase(fromBase: .binary, number: String(joinedFractional), toBase: .hex).getString ?? ""
                    
                    return convertedIntegerPart + "." + convertedFractionalPart
                }
            } else {
                return Converter().convertBase(fromBase: .binary, number: String(binary), toBase: .hex).getString ?? ""
            }
        }
        return ""
    }

}

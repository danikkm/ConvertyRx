//
//  Octal.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

final class Octal: BaseOctalConverterProtocol {
    func octalToBinaryFractional(octal: String) -> String {
        if Converter().validInput(inputNumber: octal, inputBase: .octal) {
            if octal.contains(".") {
                if let range = octal.range(of: ".") {
                    let fractionalPart = octal[range.upperBound...]
                    let integerPart = octal[..<range.lowerBound]
                    
                    let convertedIntegerPart = Converter().convertBase(fromBase: .octal, number: String(integerPart), toBase: .binary).getString ?? ""
                    let convertedFractionalPart = Converter().convertBase(fromBase: .octal, number: String(fractionalPart), toBase: .binary).getString ?? ""
                    
                    return convertedIntegerPart + "." + convertedFractionalPart
                }
            } else {
                return Converter().convertBase(fromBase: .octal, number: octal, toBase: .binary).getString ?? ""
            }
        }
        return ""
    }
    
    func octalToHexFractional(octal: String) -> String {
        if Converter().validInput(inputNumber: octal, inputBase: .octal) {
            if octal.contains(".") {
                return Binary().binaryToHexFractional(binary: octalToBinaryFractional(octal: octal))
            } else {
                return Converter().convertBase(fromBase: .octal, number: octal, toBase: .hex).getString ?? ""
            }
        }
        return ""
    }
}

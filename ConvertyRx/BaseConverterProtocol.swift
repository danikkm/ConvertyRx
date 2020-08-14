//
//  BaseConverterProtocol.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

public protocol BaseBinaryConverterProtocol {
    func binaryToOctalFractional(binary: String) -> String
    func binaryToDecimalFractional(binary: String) -> String
    func binaryToHexFractional(binary: String) -> String
}

public protocol BaseOctalConverterProtocol {
    func octalToBinaryFractional(octal: String) -> String
    func octalToDecimalFractional(octal: String) -> String
    func octalToHexFractional(octal: String) -> String
}

public protocol BaseDecimalConverterProtocol {
    func decimalToBinaryFractional(inputDecimal: String) -> String
    func decimalToOctalFractional(inputDecimal: String) -> String
    func decimalToHexFractional(inputDecimal: String) -> String
}

public protocol BaseHexConverterProtocol {
    func hexToBinaryFractional(hex: String) -> String
    func hexToOctalFractional(hex: String) -> String
    func hexToDecimalFractional(hex: String) -> String
}


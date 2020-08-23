//
//  BaseConverterProtocol.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-14.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

protocol BaseBinaryConverterProtocol {
    func binaryToOctalFractional(binary: String) -> String
    func binaryToHexFractional(binary: String) -> String
}

protocol BaseOctalConverterProtocol {
    func octalToBinaryFractional(octal: String) -> String
    func octalToHexFractional(octal: String) -> String
}

protocol BaseDecimalConverterProtocol {
    func convertToDecimalFractional(fromBase base: Base, regexBase: RegexBase, number: String) -> String
    func convertFromDecimalFractional(toBase base: Base, number: String) -> String
}

 protocol BaseHexConverterProtocol {
    func hexToBinaryFractional(hex: String) -> String
    func hexToOctalFractional(hex: String) -> String
}

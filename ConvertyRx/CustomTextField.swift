//
//  CustomTextField.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-23.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import UIKit

enum ValueType: Int {
    case none
    case binary
    case octal
    case decimal
    case hex
}

class CustomTextField: UITextField {
    @IBInspectable var maxLength: Int = 0
    var valueType: ValueType = ValueType.none
    @IBInspectable var allowedCharInString: String = ""
    
    func verifyFields(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch valueType {
            case .none:
                break // Do nothing
        
            case .binary:
                let binary = CharacterSet(charactersIn: "01.")
                if string.rangeOfCharacter(from: binary.inverted) != nil {
                    return false
            }
            case .octal:
                let binary = CharacterSet(charactersIn: "01234567.")
                if string.rangeOfCharacter(from: binary.inverted) != nil {
                    return false
            }
            case .decimal:
                let binary = CharacterSet(charactersIn: "0123456789.")
                if string.rangeOfCharacter(from: binary.inverted) != nil {
                    return false
            }
            case .hex:
                let binary = CharacterSet(charactersIn: "0123456789ABCDEF.")
                if string.rangeOfCharacter(from: binary.inverted) != nil {
                    return false
            }
            
        }
        
        if let text = self.text, let textRange = Range(range, in: text) {
            let finalText = text.replacingCharacters(in: textRange, with: string)
            if maxLength > 0, maxLength < finalText.utf8.count {
                return false
            }
        }
        
        // Check supported custom characters
        if !self.allowedCharInString.isEmpty {
            let customSet = CharacterSet(charactersIn: self.allowedCharInString)
            if string.rangeOfCharacter(from: customSet.inverted) != nil {
                return false
            }
        }
        
        return true
    }

}

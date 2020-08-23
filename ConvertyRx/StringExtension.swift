//
//  StringExtension.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-21.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import Foundation

extension String {
    var removeTrailingZeros: String {
        self.replacingOccurrences(of: "0*$", with: "", options: .regularExpression)
    }
    //FIXME: not working, replace with proper implementation
    var removeTrailingLettersAndDigits: String {
        self.replacingOccurrences(of: "([a-fA-F0-9]{2,})+(?:\\1)$", with: "", options: .regularExpression)
    }
}

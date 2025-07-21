//
//  String+Sanitize.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 11.07.2025.
//

import Foundation

extension String {
    
    func sanitizedAsDigitsOnly(maxLength: Int = 10) -> String {
        let filtered = self.filter { $0.isNumber }
        return String(filtered.prefix(maxLength))
    }
    
    func sanitizedAsMultipleInput() -> String {
        var filtered = ""
        var hasSeparator = false

        for (i, char) in self.enumerated() {
            if char.isWholeNumber {
                filtered.append(char)
                hasSeparator = false
            } else if char == "," || char == "." {
                guard i != 0, !hasSeparator else { continue }
                filtered.append(",")
                hasSeparator = true
            }
        }

        return filtered
    }
}

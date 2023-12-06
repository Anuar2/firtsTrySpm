//
//  String+Extenstion.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation
import UIKit

extension String {
    
    /// To get the height of String by setting font and width of the string
    /// - Parameters:
    ///   - width: Set maximum of the width of string
    ///   - font: Set font to calculate the size of String
    /// - Returns: Get string height in CGFloat
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Calculate the width of the string
    /// - Parameter font: Set font that will be used
    /// - Returns: the width of the string by setted font
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    /// Only first letter is capital
    var firstCapitalized: String { return prefix(1).capitalized + self.lowercased().dropFirst() }
    
    /// Try to get Double from string, in other case get 0.0
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
    
    /// Use NSPredicate to validate throuhg RexEx
    /// - Returns: Result of  is it email or not
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let PHONE_REGEX = "^\\d{3} \\d{3} \\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    var textWithoutPhoneMask: String {
        guard !self.isEmpty else { return self }
        if self.count == 0 {
            return self
        }
        var phone = self
        if Array(self)[0] == "+" && self.count > 1 {
            phone.removeFirst()
            phone.removeFirst()
        } else if Array(self)[0] == "+" && self.count == 1 {
            return self.textWithoutPlus
        }
        var result = ""
        let numbers: Array<Character> = ["0","1","2","3","4","5","6","7","8","9"]
        for character in phone {
            if numbers.contains(character) {
                result.append(character)
            }
        }
        if result.count == 0 {
            return result
        }
        if result.count == 11 {
            result.removeFirst()
        }
        return result
    }
    
    var isValidPhoneByAmount: Bool {
        return self.count == 10
    }
    
    var textWithoutPlus: String {
        var phone = self
        guard !self.isEmpty else { return self }
        if Array(self)[0] == "+" {
            phone.removeFirst()
        }
        var result = ""
        let numbers: Array<Character> = ["0","1","2","3","4","5","6","7","8","9"]
        for character in phone {
            if numbers.contains(character) {
                result.append(character)
            }
        }
        if result.count == 0 {
            return result
        }
        if result.count == 13 {
            result.removeFirst()
        }
        return result
    }
    func numberFormat(from mask: String, char: Character = "#") -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == char {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}


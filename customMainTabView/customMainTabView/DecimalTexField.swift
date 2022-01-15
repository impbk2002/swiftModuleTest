//
//  DecimalTexField.swift
//  customMainTabView
//
//  Created by pbk on 2021/12/30.
//

import Foundation
import UIKit

@propertyWrapper
struct DecimalTextField {
    let formatter:NumberFormatter
    private weak var field:UITextField?
    var wrappedValue:UITextField? {
        get {
            field
        }
        set {
            field = newValue
        }
    }
    var projectedValue:Double {
        get {
            guard let text = wrappedValue?.text,
                  let number = formatter.number(from: text)?.doubleValue,
                  number.isFinite
            else {
                return 0
            }
            return number
        }
        set {
            guard newValue.isFinite else { return }
            wrappedValue?.text = formatter.string(from: newValue as NSNumber)
        }
    }
    init(formatter:NumberFormatter) {
        self.formatter = formatter
    }
}

@propertyWrapper
class DecimalTextWrapper: NSObject, UITextFieldDelegate {
    let formatter:NumberFormatter
    private weak var field:UITextField?
    var wrappedValue:UITextField? {
        get {
            field
        }
        set {
            field = newValue
            newValue?.delegate = self
        }
    }
    var projectedValue:Double {
        get {
            guard
                let text = wrappedValue?.text,
                let number = formatter.number(from: text)?.doubleValue,
                number.isFinite
            else {
                return 0
            }
            return number
        }
        set {
            guard newValue.isFinite
            else {
                return
            }
            wrappedValue?.text = formatter.string(from: newValue as NSNumber)
        }
    }
    init(formatter:NumberFormatter) {
        self.formatter = formatter
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charSet = Set("1234567890-.".unicodeScalars.map(Character.init))
        let new:String
        if let _old = textField.text, var newRange = Range(range, in: _old) {
            if string == "", "," == _old[newRange] {
                let start = _old.index(before: newRange.lowerBound)
                newRange = start..<newRange.upperBound
            }

            new = _old.replacingCharacters(in: newRange, with: string).filter(charSet.contains)
        } else {
            new = string.filter(charSet.contains)
        }

        guard
            !new.isEmpty,
            let numberValue = formatter.number(from: new)?.decimalValue
        else {
            textField.text = formatter.string(from: 0)
            return false
        }
        guard
            numberValue.isNormal || numberValue.isZero
        else {
            return false
        }
        textField.text = formatter.string(from: numberValue as NSNumber)
        return false
    }
    
}

extension NSCharacterSet {
    var codePoints:[UTF32Char] {
        Range<UInt8>(0...16)
            .filter(hasMemberInPlane)
            .map(UInt32.init)
            .map{ plane -> Range<UTF32Char> in
                let start = plane << 16
                let nextStart = (plane + 1) << 16
                return (start..<nextStart)
            }
            .map{ $0.filter(longCharacterIsMember)
            }.reduce([], +)
    }
    
    var characters:[Character] {
        String(decoding: codePoints, as: UTF32.self).unicodeScalars.map(Character.init)
    }
}

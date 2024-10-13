//
//  ValidableTextField.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 13/10/24.
//

import Foundation

import UIKit

// Extend UITextField for validation purposes
class ValidableTextField: UITextField {

    var textInput: UITextField
    
    init(textInput: UITextField) {
      self.textInput = textInput
      super.init(frame: .zero)  // Initialize the superclass with a default frame
    }

    // Required initializer when creating the view from a storyboard or xib
    required init?(coder: NSCoder) {
      self.textInput = UITextField() // Initialize with a default input
      super.init(coder: coder)
    }
    
    // Custom error for text field validation
    enum TextFieldError: Error {
        case emptyField(String)
        case invalidEmail(String)
        case invalidPassword(String)
    }
}

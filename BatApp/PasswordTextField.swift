//
//  PasswordTextField.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 13/10/24.
//

import Foundation


class PasswordTextField: ValidableTextField, Validable {
    
    func validate() throws {
        guard let text = textInput.text, !text.isEmpty else {
            throw TextFieldError.emptyField("Password cannot be empty!")
        }
        
        if text.count < 8 {
            throw TextFieldError.invalidPassword("Password must be at least 8 characters.")
        }
        
    }
}

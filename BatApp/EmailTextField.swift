//
//  EmailTextField.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 13/10/24.
//

import Foundation

class EmailTextField: ValidableTextField, Validable {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern) // filter collections of objects
        return emailPred.evaluate(with: email)
    }
    
    func validate() throws {
        guard let text = textInput.text, !text.isEmpty else {
            throw TextFieldError.emptyField("Email cannot be empty!")
        }
        
        // Check if the email is valid
        if !isValidEmail(text) {
            throw TextFieldError.invalidEmail("Invalid email")
        }
    }
}

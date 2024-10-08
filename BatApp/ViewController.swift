//
//  ViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 1/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    enum LoginError: Error {
        case emptyPassword
        case invalidPassword
        case emptyEmail
        case invalidEmail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func displayAlert (_ title: String, _ description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        // Add a default OK action to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern) // filter collections of objects
        return emailPred.evaluate(with: email)
    }
    
    func login(_ email: String, _ password: String) throws {
        // Check if the password is valid
        if password.count < 8 {
            throw LoginError.invalidPassword
        }
    }
    
    func validateFields() throws {
        guard let email = emailInput.text, !email.isEmpty else {
            throw LoginError.emptyEmail
        }
        
        guard let password = passwordInput.text, !password.isEmpty else {
            throw LoginError.emptyPassword
        }
        
        // Check if the email is valid
        if !isValidEmail(email) {
            throw LoginError.invalidEmail
        }
    }



    @IBAction func loginEvent(_ sender: UIButton) {
        do {
            // Check the fields
            try validateFields()
            
            // Safely unwrap the text fields
            guard let email = emailInput.text, let password = passwordInput.text else {
                throw LoginError.emptyEmail  // This should not happen due to earlier validation, but adding as a safeguard
            }
            
            try login(email, password)
            
            displayAlert("Validated","Success login")
            
        } catch LoginError.emptyEmail {
            displayAlert("ERROR", "Email cannot be empty!")
        } catch LoginError.emptyPassword {
            displayAlert("ERROR", "Password cannot be empty!")
        } catch LoginError.invalidEmail {
            displayAlert("ERROR", "Invalid email")
        } catch LoginError.invalidPassword {
            displayAlert("ERROR", "Password must be at least 8 characters.")
        } catch {
            displayAlert("ERROR", "Login failed.")
        }
    }
}


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
    
    var emailTextField: EmailTextField?
    var passwordTextField: PasswordTextField?
    
    
    enum LoginError: Error {
        case emptyPassword
        case invalidPassword
        case emptyEmail
        case invalidEmail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField = EmailTextField(textInput: emailInput)
        passwordTextField = PasswordTextField(textInput: passwordInput)
    }
    
    func displayAlert (_ title: String, _ description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        // Add a default OK action to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        self.present(alert, animated: true, completion: nil)
    }


    @IBAction func loginEvent(_ sender: UIButton) {
        do {
            // Check the fields
            try emailTextField?.validate()
            try passwordTextField?.validate()
            
            
            displayAlert("Validated","Success login.")
            
        } catch let error as ValidableTextField.TextFieldError {
            switch error {
            case .invalidEmail(let field):
                displayAlert("ERROR", field)
            case .invalidPassword(let field):
                displayAlert("ERROR", field)
            case .emptyField(let field):
                displayAlert("ERROR", field)
            }
        } catch {
            displayAlert("ERROR", "Login not success.")
        }
    }
}


//
//  ViewController.swift
//  VibeCheck
//
//  Created by MacBook Pro on 19.02.2026.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var loginViewModel = LoginViewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterView", sender: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        loginViewModel.email = emailTextField.text!
        loginViewModel.password = passwordTextField.text!
        loginViewModel.login { checkLogin in
            if !checkLogin {
                self.showErrorAlert(message: self.loginViewModel.errorMessage)
            } else {
                self.performSegue(withIdentifier: "toTabBarFromLoginView", sender: nil)
            }
        }
    }
    
    private func showErrorAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    
    @IBAction func forgotPassword(_ sender: Any) {
        
    }
    
}


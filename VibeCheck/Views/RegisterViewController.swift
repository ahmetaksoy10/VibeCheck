//
//  RegisterView.swift
//  VibeCheck
//
//  Created by MacBook Pro on 19.02.2026.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var registerViewModel = RegisterViewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        registerViewModel.email = emailTextField.text!
        registerViewModel.name = usernameTextField.text!
        registerViewModel.password = passwordTextField.text!
        registerViewModel.register { checkRegister in
            if !checkRegister {
                self.showErrorAlert(message: self.registerViewModel.errorMessage)
            } else {
                self.performSegue(withIdentifier: "toTabBarFromRegisterView", sender: nil)
            }
        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        performSegue(withIdentifier: "toLoginFromRegisterView", sender: nil)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

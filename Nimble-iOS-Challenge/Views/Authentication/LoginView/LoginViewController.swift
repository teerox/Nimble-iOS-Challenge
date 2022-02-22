//
//  LoginViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/22/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var forgotPassWordBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot? ", for: .normal)
        button.tintColor = .lightGray
        button.alpha = 1
        return button
    }()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.rightView = forgotPassWordBtn
        passwordField.rightViewMode = .always
        forgotPassWordBtn.addTarget(self, action: #selector(handleForgotPassword(sender:)), for: .touchUpInside)
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        
    }
    
    @objc func handleForgotPassword(sender: UIButton) {
        
    }
}

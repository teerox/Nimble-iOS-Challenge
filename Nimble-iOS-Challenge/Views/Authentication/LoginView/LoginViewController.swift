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
    
    let viewModel = LoginViewModel(apiClient: APIClient(cachedData: CacheData()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.rightView = forgotPassWordBtn
        passwordField.rightViewMode = .always
        forgotPassWordBtn.addTarget(self, action: #selector(handleForgotPassword(sender:)), for: .touchUpInside)
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        if !emailField.text!.isEmpty && !passwordField.text!.isEmpty {
            let progressBar = Loader(text: "Please Wait")
            self.view.addSubview(progressBar)
            viewModel.loginInUser(email: emailField.text!, password: passwordField.text!) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if self.viewModel.loginSuccessful {
                        self.openHomeView()
                    }
                }
            } onFailure: { error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.showAlert("Error", error)
                }
            } loading: { loading in
                DispatchQueue.main.async {
                    if loading {
                        progressBar.show()
                    } else {
                        progressBar.hide()
                    }
                }
            }
        } else {
            showAlert("Login Error", "Enter Email and Password")
        }
    }
    
    func openHomeView() {
        let vc = SingleHomeComponentViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func handleForgotPassword(sender: UIButton) {
        
    }
}

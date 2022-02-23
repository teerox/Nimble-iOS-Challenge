//
//  ForgotPasswordViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/23/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    let viewModel = LoginViewModel(apiClient: APIClient(cachedData: CacheData()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        if !emailField.text!.isEmpty {
            let progressBar = Loader(text: "Please Wait")
            self.view.addSubview(progressBar)
            viewModel.resetPassword(email: emailField.text!) { value in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if self.viewModel.passwordResetSuccess {
                        self.dismisView()
                    } else {
                        self.showAlert("", value)
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
            showAlert("", "Enter Email")
        }
        
        
    }
    
    @IBAction func disMiss(_ sender: UIButton) {
        dismisView()
    }
    
    func dismisView() {
        dismiss(animated: true) {}
    }
}

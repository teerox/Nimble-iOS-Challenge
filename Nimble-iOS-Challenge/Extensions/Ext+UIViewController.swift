//
//  Ext+UIViewController.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

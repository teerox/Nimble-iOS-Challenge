//
//  Ext+UITextField.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/22/22.
//

import Foundation
import UIKit

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

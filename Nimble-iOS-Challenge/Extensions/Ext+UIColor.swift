//
//  Ext+UIColor.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/23/22.
//

import Foundation
import UIKit

//Colour extension
public extension UIColor {
    
    // static variable to set the primary color through the application
    static let primary = "9B7DD4"
    static let darker = "202124"
    static let dark = "403E54"
    static let secondary = "4300C2"
    static let white = "ffffff"
    
    static func whiteColor() -> UIColor{
        let color =  UIColor.hexStringToUIColor(hex: UIColor.white)
        return color
    }
    
    // function to convert a string to the UIcolor class
    static  func hexStringToUIColor (hex:String) -> UIColor {
        //trim string and make it upper cased
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        //check for # in string
        if (cString.hasPrefix("#")) {
            //if found remove
            cString.remove(at: cString.startIndex)
        }
        
        //fallback if colour is not up to 6
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        //convert string to UInt32
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        //return UIColor
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func gradientDarkGrey() -> UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static func gradientLightGrey() -> UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
}



//
//  Ext+String.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation
import UIKit

public extension String{
    
    var getColor: UIColor{
        get{
            return UIColor.hexStringToUIColor(hex: self)
        }
    }
    
}

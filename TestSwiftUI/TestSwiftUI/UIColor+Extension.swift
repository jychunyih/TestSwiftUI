//
//  UIColor+Extension.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/10.
//  Copyright © 2016年 chunyih. All rights reserved.
//

typealias TSColor = UIColor.LocalColorName

import Foundation
import UIColor_Hex_Swift
import UIKit

extension UIColor {
    enum LocalColorName : String {
        case barTintColor = "#31404C"  /*navigationbar 的颜色*/
        case tabbarSelectedTextColor = "#68BB1E"
        case viewBackgroundColor = "#E7EBEE"
        case cardBackgroundColor = "#00B589"
    }
    
    convenience init!(colorNamed name: LocalColorName) {
        self.init(rgba: name.rawValue)
    }
}
//
//  NSObject+String.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
    
    //用于获取 cell 的 reuse identifier
    class var identifier: String {
        return String(format: "%@_identifier", self.nameOfClass)
    }
}
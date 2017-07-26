//
//  ExtensionDate.swift
//  Map
//
//  Created by may985 on 7/21/17.
//  Copyright © 2017 may985. All rights reserved.
//

import Foundation
extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

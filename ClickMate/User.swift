//
//  User.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/6/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import Foundation

class User {
    var email = ""
    var uid = ""

    func getDict() -> [String:String]? {
        if email != "" {
            return ["email": email, "uid":uid ]
    
        } else {
            return nil
        }
    }
}

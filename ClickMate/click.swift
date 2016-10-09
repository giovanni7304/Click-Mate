//
//  Click.swift
//  ClickMate
//
//  Created by Terry Johnson on 10/6/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import Foundation

class Click {
    var imageURL = ""
    var descrip = ""
    var from = ""
    var key = ""
    var uuid = ""
    
    func getDict() -> [String:String]? {
        if imageURL != "" {
            return ["from": from, "imageURL":imageURL, "description": descrip ]
        } else {
            return nil
        }
    }
}

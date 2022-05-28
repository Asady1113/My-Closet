//
//  User.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/09/26.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

class User: NSObject {
   
    var objectId: String
    var userName: String
    
    init(objectId: String, userName: String) {
    self.objectId = objectId
    self.userName = userName
    }
}

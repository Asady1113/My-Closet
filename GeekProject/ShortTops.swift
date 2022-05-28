//
//  ShortTops.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/09/30.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

class ShortTops: NSObject  {
    
    var objectId: String
    var user: User
    var imageUrl: String
    var brandName : String
    var buyDate : String
    var comment : String
    var price : String
    var putOnCount : Int
    var colorNumber : Int
    
    init(objectId: String, user: User, imageUrl: String, brandName: String, buyDate: String, comment: String, price: String,putOnCount: Int,colorNumber: Int) {
        self.objectId = objectId
        self.user = user
        self.imageUrl = imageUrl
        self.brandName = brandName
        self.buyDate = buyDate
        self.comment = comment
        self.price = price
        self.putOnCount = putOnCount
        self.colorNumber = colorNumber
    }
}

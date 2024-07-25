//
//  CoffeeModel.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 25.07.24.
//

import Foundation


struct CoffeeModel {
    let id : String
    let imgURL : String
    let name : String
    let price : Double
    let isFavorite : Bool
    
    init( dictionary : [String : Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.imgURL = dictionary["imgURL"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.price = dictionary["price"] as? Double ?? 0
        self.isFavorite = dictionary["isFavorite"] as? Bool ?? false
    }
}

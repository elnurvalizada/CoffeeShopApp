//
//  CoffeeModel.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 16.07.24.
//

import Foundation

struct CoffeeModel : Codable {
    let _id : String
    let name : String
    let description : String
    let price : Double
    let image_url : String
}

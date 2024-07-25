//
//  CoffeeManager.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 25.07.24.
//

import Foundation
import Firebase

class CoffeeManager {
    static let shared = CoffeeManager()
    
    private init() {}
    
    func fetchAllCoffees(completion: @escaping ([CoffeeModel]) -> Void) {
        Firestore.firestore().collection("Coffee").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }
            
            let coffeeList = documents.compactMap { doc -> CoffeeModel? in
                let data = doc.data()
                return CoffeeModel(dictionary: data)
            }
            
            completion(coffeeList)
        }
    }
    
    func fetchFavCoffees(completion: @escaping ([CoffeeModel]) -> Void) {
        Firestore.firestore().collection("FavoriteCoffee").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }
            
            let coffeeList = documents.compactMap { doc -> CoffeeModel? in
                let data = doc.data()
                return CoffeeModel(dictionary: data)
            }
            
            completion(coffeeList)
        }
    }
    
    func listenToCoffeeUpdates(completion: @escaping ([CoffeeModel]) -> Void) {
        Firestore.firestore().collection("FavoriteCoffee").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }
            
            let coffeeList = documents.compactMap { doc -> CoffeeModel? in
                let data = doc.data()
                return CoffeeModel(dictionary: data)
            }
            
            completion(coffeeList)
        }
    }
}

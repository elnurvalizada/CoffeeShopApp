//
//  NetworkManager.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 16.07.24.
//

import Foundation


final class NetworkManager {
    func fetchProducts(completion: @escaping ([CoffeeBeansModel]) -> Void) {
        URLSession.shared.fetch(url: "https://fake-coffee-api.vercel.app/api", expecting: [CoffeeBeansModel].self) { (result: Result<[CoffeeBeansModel], Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(data)
                }
            case .failure(let error):
                print("----------------", error)
                break
            }
        }
    }
}



extension URLSession {
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func fetch<T: Codable>( url: String, expecting: T.Type, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

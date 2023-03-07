//
//  APICaller.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://reqres.in/api/"
    static let allUser = "users"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getAllUser(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.allUser)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(results.data!))
                print(results.data!)
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
}

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
    static let page = "users?page="
    static let unknown = "unknown"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    // All User
    func getAllUser(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.allUser)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(results.data!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    // Page
    func getPage(with query: String, completion: @escaping (Result<[User], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.page)\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(results.data!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    // All unknown
    func getAllColor(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.unknown)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(results.data!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}

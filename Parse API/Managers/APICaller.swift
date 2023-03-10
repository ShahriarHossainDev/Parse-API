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
    
    func createUser(with parameters: String, completion: @escaping (Result<CreateUser, Error>) -> Void) {
        //let parameters = "{\n    \"name\": \"shishr\",\n    \"job\": \"ios developer\"\n}"
        let postData = parameters.data(using: .utf8)
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.allUser)") else { return }
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(CreateUser.self, from: data)
                completion(.success(results))
                print(results)
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
            //print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        
    }
}

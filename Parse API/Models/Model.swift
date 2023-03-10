//
//  Model.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import Foundation

struct UserResponse: Codable {
    let page : Int?
    let per_page : Int?
    let total : Int?
    let total_pages : Int?
    let data : [User]?
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case per_page = "per_page"
        case total = "total"
        case total_pages = "total_pages"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        data = try values.decodeIfPresent([User].self, forKey: .data)
    }
}

struct User: Codable {
    let id : Int?
    let email : String?
    let first_name : String?
    let last_name : String?
    let avatar : String?
    
    // Color
    let name : String?
    let color : String?
    let pantoneValue : String?
    
    let job : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case email = "email"
        case first_name = "first_name"
        case last_name = "last_name"
        case avatar = "avatar"
        
        // Color
        case name = "name"
        case color = "color"
        case pantoneValue = "pantone_value"
        case job = "job"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        
        // Color
        color = try values.decodeIfPresent(String.self, forKey: .color)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        pantoneValue = try values.decodeIfPresent(String.self, forKey: .pantoneValue)
        
        job = try values.decodeIfPresent(String.self, forKey: .job)
    }
}


struct CreateUser: Codable {
    let id : String?
    let name : String?
    let job : String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case job = "job"
        case createdAt = "createdAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        job = try values.decodeIfPresent(String.self, forKey: .job)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }
    
}

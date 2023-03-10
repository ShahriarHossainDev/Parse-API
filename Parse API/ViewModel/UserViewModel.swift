//
//  UserViewModel.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import Foundation

struct UserViewModel {
    let firstName: String
    let lastName: String
    let email: String
    let avatarURL: String
}

struct ColorViewModel {
    let name : String
    let color : String
    let pantoneValue : String
}

struct CreateUserViewModel {
    let id : String
    let name : String
    let job : String
    let createdAt: String
}

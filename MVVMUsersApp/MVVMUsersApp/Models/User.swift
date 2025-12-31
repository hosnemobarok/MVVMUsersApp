//
//  User.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let company: Company

    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

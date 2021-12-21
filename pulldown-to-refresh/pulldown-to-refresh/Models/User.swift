//
//  User.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import Foundation
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
// let url = URL(string: "https://jsonplaceholder.typicode.com/users")

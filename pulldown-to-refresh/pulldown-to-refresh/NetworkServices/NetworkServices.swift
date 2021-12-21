//
//  NetworkServices.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import Foundation

class NetworkServices {
    static let shared = NetworkServices()
    
    func getUsers(completion: @escaping (Result<[User],MyErrors>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                completion(.failure(MyErrors.invalidAPICall))
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data!)
                completion(.success(users))
            } catch {
                completion(.failure(MyErrors.invalidAPICall))
            }
        }.resume()
    }
}

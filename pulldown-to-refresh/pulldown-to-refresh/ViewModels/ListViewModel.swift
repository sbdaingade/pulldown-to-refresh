//
//  ListViewModel.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published public var users: [User] = [User]()
    @Published  var showProgressView = false
    @Published var customError: MyErrors?
    
    
    public enum Input {
        case getAllUser
    }
    @Published var input: Input?
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        $input.compactMap{$0}.sink{ [unowned self] actions in
            switch actions {
            case .getAllUser:
                self.getUsers {[unowned self] newUsers in
                    self.users = newUsers
                }
            }
        }.store(in: &cancellables)
    }
    
    
    private func getUsers(completion: @escaping ([User]) -> Void) {
        showProgressView = true
        NetworkServices.shared.getUsers { [unowned self] (result:Result<[User], MyErrors>) in
            showProgressView = false
            switch result {
            case .success(let newUsers):
                completion(newUsers)
            case .failure(let authError):
                print("\(authError.errorDescription ?? "custom error message")")
            }
        }
    }
    
    deinit {
        cancellables.forEach{$0.cancel()}
    }
}

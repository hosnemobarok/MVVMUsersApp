//
//  UserListViewModel.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


import Foundation

final class UserListViewModel {

    private let apiClient: APIClientProtocol
    private(set) var users: [User] = []

    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchUsers() {
        apiClient.request(urlString: "https://jsonplaceholder.typicode.com/users") { [weak self] (result: Result<[User], APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.onDataUpdate?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }

    func numberOfRows() -> Int { users.count }
    func user(at index: Int) -> User { users[index] }
}

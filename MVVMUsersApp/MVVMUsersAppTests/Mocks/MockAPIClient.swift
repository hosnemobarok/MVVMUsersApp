//
//  MockAPIClient.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


import Foundation
@testable import MVVMUsersApp

final class MockAPIClient: APIClientProtocol {

    var shouldFail = false
    var mockUsers: [User] = []

    func request<T>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        if shouldFail {
            completion(.failure(.networkError(NSError(domain: "", code: -1, userInfo: nil))))
        } else {
            if let users = mockUsers as? T {
                completion(.success(users))
            } else {
                completion(.failure(.decodingError))
            }
        }
    }
}

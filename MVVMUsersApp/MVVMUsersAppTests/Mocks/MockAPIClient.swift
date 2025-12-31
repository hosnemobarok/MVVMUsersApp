//
//  MockAPIClient.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


@testable import MVVMUsersApp

final class MockAPIClient: APIClientProtocol {

    var shouldFail = false
    var mockUsers: [User] = []

    func request<T>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        if shouldFail {
            completion(.failure(.noData))
        } else {
            completion(.success(mockUsers as! T))
        }
    }
}

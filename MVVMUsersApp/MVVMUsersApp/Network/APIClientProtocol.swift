//
//  APIClientProtocol.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


protocol APIClientProtocol {
    func request<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, APIError>) -> Void
    )
}

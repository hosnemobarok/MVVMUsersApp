//
//  APIError.swift
//  MVVMUsersApp
//
//  Created by Md Hosne Mobarok on 12/31/25.
//


import Foundation

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
    case decodingError

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .networkError(let error): return error.localizedDescription
        case .invalidResponse: return "Invalid response from server."
        case .noData: return "No data received."
        case .decodingError: return "Failed to decode data."
        }
    }
}

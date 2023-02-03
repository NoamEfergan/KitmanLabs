//
//  NetworkService.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

// MARK: - NetworkService
final class NetworkService {
    func perform<T: Codable>(path: String,
                             responseType: T.Type,
                             requestType: HTTPMethods,
                             body: [String: String]?) async throws
        -> T {
        guard let url: URL = .init(string: Constants.baseURL + path) else {
            throw NetworkError.invalidURL
        }
            var session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = requestType.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body {
                let encoded = try JSONEncoder().encode(body)
                request.httpBody = encoded
            }
            let (data, response) = try await session.data(for: request)
            
            print(data)
            print(response)
            throw NetworkError.invalidURL
            
    }
}

// MARK: NetworkService.NetworkError
extension NetworkService {
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
    }
}


// MARK: - HTTPMethods
/// At the moment these are the only ones used, more can be added if needed, like PUT, DELETE or whatever
enum HTTPMethods: String {
    case GET
    case POST
}

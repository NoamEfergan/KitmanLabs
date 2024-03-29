//
//  NetworkService.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

// MARK: - NetworkService

final class NetworkService {
    func perform<T: Codable>(path: Constants.Paths,
                             responseType _: T.Type,
                             requestType: HTTPMethods,
                             body: [String: String]? = nil) async throws
        -> T
    {
        guard let url: URL = .init(string: Constants.baseURL + path.rawValue) else {
            throw NetworkError.invalidURL
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body {
            let encoded = try JSONEncoder().encode(body)
            request.httpBody = encoded
        }
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200 ... 299:
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        case 400 ... 499:
            throw NetworkError.clientError
        case 500 ... 599:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknownError
        }
    }
}

// MARK: NetworkService.NetworkError

extension NetworkService {
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case serverError
        case clientError
        case unknownError
    }
}

// MARK: - HTTPMethods

/// At the moment these are the only ones used, more can be added if needed, like PUT, DELETE or whatever
enum HTTPMethods: String {
    case GET
    case POST
}

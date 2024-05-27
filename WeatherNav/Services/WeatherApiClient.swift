//
//  WeatherApiClient.swift
//  WeatherNav
//
//  Created by SofiaLeong on 24/05/2024.
//

import Foundation

final class WeatherAPIClient {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

extension WeatherAPIClient {
    func fetchData(endpoint: Endpointable) async throws -> Data {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
            
            switch response.statusCode {
            case 200...299:
                return data
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.unexpectedStatusCode
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}

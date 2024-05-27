//
//  Endpointable.swift
//  WeatherNav
//
//  Created by SofiaLeong on 24/05/2024.
//

import Foundation

protocol Endpointable {
    var path: String { get }
    var scheme: String { get }
    var method: String { get }
    var host: String { get }
    var parameters: [URLQueryItem]? { get }
    var url: URL? { get }
}

// Default values
extension Endpointable {
    var method: String { "GET" }
    
    var scheme: String { "https" }
    
    var host: String { "api.openweathermap.org" }
    
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = parameters
        
        return components.url
    }
}

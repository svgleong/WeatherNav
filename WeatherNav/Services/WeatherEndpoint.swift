//
//  WeatherEndpoint.swift
//  WeatherNav
//
//  Created by SofiaLeong on 24/05/2024.
//

import Foundation

//MARK: - Responsible for constructing the full URL from the endpoint

struct WeatherEndpoint: Endpointable {
    let city: String
    private let appid: String = "91d65d03e63bb6c97a4423a1a0a159b0"
//    private let appid: String = "YOUR_API_KEY"
    
    var path: String {
        "/data/2.5/forecast"
    }
    
    var parameters: [URLQueryItem]? {
        [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: appid),
            URLQueryItem(name: "units", value: "metric")
        ]
    }
}

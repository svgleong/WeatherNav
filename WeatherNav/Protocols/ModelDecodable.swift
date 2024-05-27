//
//  ModelDecodable.swift
//  WeatherNav
//
//  Created by SofiaLeong on 24/05/2024.
//

import Foundation

protocol ModelDecodable {
    func model<T: Decodable>(from data: Data, as type: T.Type) throws -> T
}

extension ModelDecodable {
    func model<T: Decodable>(from data: Data, as type: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}

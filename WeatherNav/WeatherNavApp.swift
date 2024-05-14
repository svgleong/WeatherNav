//
//  WeatherNavApp.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI

@main
struct WeatherNavApp: App {

    let moc = DataController.shared.container.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, moc)
        }
    }
}

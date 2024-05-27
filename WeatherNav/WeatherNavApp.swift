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
    var client: WeatherAPIClient { WeatherAPIClient(session: URLSession.shared) }
    var service: WeatherService { WeatherService(client: client) }
    var viewModel: ViewModel { ViewModel(service: service) }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext, moc)
        }
    }
}

//
//  ContentView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ViewModel
    @Environment(\.managedObjectContext) var moc
    
    init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    switch viewModel.state {
                    case .loading:
                        LoadingView()
                    case .failure:
                        FailureView(viewModel: viewModel)
                    case let .cachedFailure(model):
                        MainForecastView(viewModel: viewModel, weatherData: model)
                    case let .success(model):
                        MainForecastView(viewModel: viewModel, weatherData: model)
                    }
                }
                .foregroundColor(.white)
                .bold()
            }
        }
    }
}

#Preview {
    var client: WeatherAPIClient { WeatherAPIClient(session: URLSession.shared) }
    var service: WeatherService { WeatherService(client: client) }
    var viewModel: ViewModel { ViewModel(service: service, repo: CityRepo()) }
    return ContentView(viewModel: viewModel)
}

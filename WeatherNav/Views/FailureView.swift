//
//  FailureView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 27/05/2024.
//

import SwiftUI

struct FailureView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("No weather data.")
            Button(action: {
                Task {
                    await viewModel.loadData()
                }
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 24, height: 28)
            })
            .navigationBarItems(trailing: NavigationLink(destination: HistoryView()) {
                Image(systemName: "clock.fill")
                    .padding(5)
            })
        }
    }
}

#Preview {
    var client: WeatherAPIClient { WeatherAPIClient(session: URLSession.shared) }
    var service: WeatherService { WeatherService(client: client) }
    var viewModel: ViewModel { ViewModel(service: service, repo: CityRepo()) }
    return FailureView(viewModel: viewModel)
}

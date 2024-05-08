//
//  ContentView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                if viewModel.weatherData != nil {
                    MainForecastView(viewModel: viewModel)
                } else {
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .foregroundColor(.white)
            .bold()
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    ContentView()
}

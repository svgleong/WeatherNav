//
//  HistoryView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject private var viewModel = HistoryViewModel()
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<CityEntity>
    
    var body: some View {
        ZStack {
            // Set background color
            LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                List(viewModel.cities, id: \.self) { city in
                    NavigationLink("\(city.name)", destination: CityDetailView(city: city))
                }
            }
            .scrollContentBackground(.hidden)
        }
        .onAppear() {
            viewModel.loadData(history)
        }
    }
}

#Preview {
    HistoryView()
}
